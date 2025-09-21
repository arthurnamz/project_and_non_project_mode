#!/usr/bin/env python3
"""
RPT to CSV Parser
A script to parse Vivado .rpt files and extract relevant data into CSV format.
Supports timing summary and utilization reports.
"""

import os
import re
import csv
import argparse
from pathlib import Path
from typing import Dict, List, Any, Optional
import pandas as pd


class RPTParser:
    """Parser for Vivado .rpt files"""
    
    def __init__(self):
        self.timing_data = []
        self.utilization_data = []
        self.clock_data = []
        self.primitive_data = []
    
    def parse_timing_summary(self, file_path: str) -> Dict[str, Any]:
        """Parse timing summary report"""
        with open(file_path, 'r') as f:
            content = f.read()
        
        timing_info = {
            'file_name': os.path.basename(file_path),
            'file_path': file_path,
            'design': self._extract_value(content, r'Design\s*:\s*(\w+)'),
            'device': self._extract_value(content, r'Device\s*:\s*([^\n]+)'),
            'design_state': self._extract_value(content, r'Design State\s*:\s*([^\n]+)'),
            'wns': self._extract_timing_value(content, 'WNS'),
            'tns': self._extract_timing_value(content, 'TNS'),
            'tns_failing_endpoints': self._extract_timing_value(content, 'TNS Failing Endpoints'),
            'tns_total_endpoints': self._extract_timing_value(content, 'TNS Total Endpoints'),
            'whs': self._extract_timing_value(content, 'WHS'),
            'ths': self._extract_timing_value(content, 'THS'),
            'ths_failing_endpoints': self._extract_timing_value(content, 'THS Failing Endpoints'),
            'ths_total_endpoints': self._extract_timing_value(content, 'THS Total Endpoints'),
            'wpws': self._extract_timing_value(content, 'WPWS'),
            'tpws': self._extract_timing_value(content, 'TPWS'),
            'tpws_failing_endpoints': self._extract_timing_value(content, 'TPWS Failing Endpoints'),
            'tpws_total_endpoints': self._extract_timing_value(content, 'TPWS Total Endpoints')
        }
        
        # Extract check timing violations
        timing_info.update(self._parse_check_timing(content))
        
        return timing_info
    
    def parse_utilization_report(self, file_path: str) -> Dict[str, Any]:
        """Parse utilization report"""
        with open(file_path, 'r') as f:
            content = f.read()
        
        util_info = {
            'file_name': os.path.basename(file_path),
            'file_path': file_path,
            'design': self._extract_value(content, r'Design\s*:\s*(\w+)'),
            'device': self._extract_value(content, r'Device\s*:\s*([^\n]+)'),
            'design_state': self._extract_value(content, r'Design State\s*:\s*([^\n]+)')
        }
        
        # Parse CLB Logic section
        util_info.update(self._parse_clb_logic(content))
        
        # Parse I/O section
        util_info.update(self._parse_io_utilization(content))
        
        # Parse Clock section
        util_info.update(self._parse_clock_utilization(content))
        
        # Parse Block RAM section
        util_info.update(self._parse_blockram_utilization(content))
        
        # Parse Arithmetic section
        util_info.update(self._parse_arithmetic_utilization(content))
        
        # Parse Primitives section
        primitives = self._parse_primitives(content)
        util_info['primitives'] = primitives
        
        return util_info
    
    def _extract_value(self, content: str, pattern: str) -> str:
        """Extract a single value using regex"""
        match = re.search(pattern, content)
        return match.group(1).strip() if match else ""
    
    def _extract_timing_value(self, content: str, field_name: str) -> str:
        """Extract timing values from the Design Timing Summary table"""
        # Look for the timing summary table
        pattern = rf'{field_name}\s*\(\w+\)\s+([^\s]+)'
        match = re.search(pattern, content)
        return match.group(1).strip() if match else ""
    
    def _parse_check_timing(self, content: str) -> Dict[str, str]:
        """Parse check timing violations"""
        violations = {}
        
        # Extract each check timing section
        checks = [
            'no_clock', 'constant_clock', 'pulse_width_clock',
            'unconstrained_internal_endpoints', 'no_input_delay',
            'no_output_delay', 'multiple_clock', 'generated_clocks',
            'loops', 'partial_input_delay', 'partial_output_delay', 'latch_loops'
        ]
        
        for check in checks:
            pattern = rf'{check}\s*\((\d+)\)'
            match = re.search(pattern, content)
            violations[f'check_{check}'] = match.group(1) if match else "0"
        
        return violations
    
    def _parse_clb_logic(self, content: str) -> Dict[str, str]:
        """Parse CLB Logic utilization"""
        clb_data = {}
        
        # Extract CLB LUTs
        lut_match = re.search(r'CLB LUTs\s*\|\s*(\d+)\s*\|\s*\d+\s*\|\s*\d+\s*\|\s*(\d+)\s*\|\s*([^\|]+)', content)
        if lut_match:
            clb_data['clb_luts_used'] = lut_match.group(1)
            clb_data['clb_luts_available'] = lut_match.group(2)
            clb_data['clb_luts_util_percent'] = lut_match.group(3).strip()
        
        # Extract CLB Registers
        reg_match = re.search(r'CLB Registers\s*\|\s*(\d+)\s*\|\s*\d+\s*\|\s*\d+\s*\|\s*(\d+)\s*\|\s*([^\|]+)', content)
        if reg_match:
            clb_data['clb_registers_used'] = reg_match.group(1)
            clb_data['clb_registers_available'] = reg_match.group(2)
            clb_data['clb_registers_util_percent'] = reg_match.group(3).strip()
        
        return clb_data
    
    def _parse_io_utilization(self, content: str) -> Dict[str, str]:
        """Parse I/O utilization"""
        io_data = {}
        
        # Extract Bonded IOB
        iob_match = re.search(r'Bonded IOB\s*\|\s*(\d+)\s*\|\s*\d+\s*\|\s*\d+\s*\|\s*(\d+)\s*\|\s*([^\|]+)', content)
        if iob_match:
            io_data['bonded_iob_used'] = iob_match.group(1)
            io_data['bonded_iob_available'] = iob_match.group(2)
            io_data['bonded_iob_util_percent'] = iob_match.group(3).strip()
        
        return io_data
    
    def _parse_clock_utilization(self, content: str) -> Dict[str, str]:
        """Parse Clock utilization"""
        clock_data = {}
        
        # Extract BUFGCE
        bufgce_match = re.search(r'BUFGCE\s*\|\s*(\d+)\s*\|\s*\d+\s*\|\s*\d+\s*\|\s*(\d+)\s*\|\s*([^\|]+)', content)
        if bufgce_match:
            clock_data['bufgce_used'] = bufgce_match.group(1)
            clock_data['bufgce_available'] = bufgce_match.group(2)
            clock_data['bufgce_util_percent'] = bufgce_match.group(3).strip()
        
        return clock_data
    
    def _parse_blockram_utilization(self, content: str) -> Dict[str, str]:
        """Parse Block RAM utilization"""
        bram_data = {}
        
        # Extract Block RAM Tile
        bram_match = re.search(r'Block RAM Tile\s*\|\s*(\d+)\s*\|\s*\d+\s*\|\s*\d+\s*\|\s*(\d+)\s*\|\s*([^\|]+)', content)
        if bram_match:
            bram_data['block_ram_used'] = bram_match.group(1)
            bram_data['block_ram_available'] = bram_match.group(2)
            bram_data['block_ram_util_percent'] = bram_match.group(3).strip()
        
        return bram_data
    
    def _parse_arithmetic_utilization(self, content: str) -> Dict[str, str]:
        """Parse Arithmetic utilization"""
        dsp_data = {}
        
        # Extract DSPs
        dsp_match = re.search(r'DSPs\s*\|\s*(\d+)\s*\|\s*\d+\s*\|\s*\d+\s*\|\s*(\d+)\s*\|\s*([^\|]+)', content)
        if dsp_match:
            dsp_data['dsp_used'] = dsp_match.group(1)
            dsp_data['dsp_available'] = dsp_match.group(2)
            dsp_data['dsp_util_percent'] = dsp_match.group(3).strip()
        
        return dsp_data
    
    def _parse_primitives(self, content: str) -> List[Dict[str, str]]:
        """Parse Primitives section"""
        primitives = []
        
        # Find the Primitives section
        primitives_section = re.search(r'9\. Primitives.*?(?=10\.|$)', content, re.DOTALL)
        if primitives_section:
            # Extract primitive data from table
            lines = primitives_section.group(0).split('\n')
            for line in lines:
                if '|' in line and 'Ref Name' not in line and 'Used' not in line and '----' not in line:
                    parts = [p.strip() for p in line.split('|') if p.strip()]
                    if len(parts) >= 3:
                        primitives.append({
                            'ref_name': parts[0],
                            'used': parts[1],
                            'functional_category': parts[2]
                        })
        
        return primitives


def process_rpt_files(input_path: str, output_csv: str, report_type: str = "all"):
    """Process .rpt files and generate CSV output"""
    parser = RPTParser()
    all_data = []
    
    # Find all .rpt files
    rpt_files = []
    if os.path.isfile(input_path) and input_path.endswith('.rpt'):
        rpt_files = [input_path]
    elif os.path.isdir(input_path):
        rpt_files = list(Path(input_path).rglob('*.rpt'))
    else:
        print(f"Error: {input_path} is not a valid file or directory")
        return
    
    print(f"Found {len(rpt_files)} .rpt files")
    
    for rpt_file in rpt_files:
        print(f"Processing: {rpt_file}")
        
        try:
            with open(rpt_file, 'r') as f:
                content = f.read()
            
            # Determine report type
            if 'Timing Summary Report' in content or 'timing_summary' in str(rpt_file):
                if report_type in ["all", "timing"]:
                    data = parser.parse_timing_summary(str(rpt_file))
                    data['report_type'] = 'timing'
                    all_data.append(data)
            elif 'Utilization Design Information' in content or 'utilization' in str(rpt_file):
                if report_type in ["all", "utilization"]:
                    data = parser.parse_utilization_report(str(rpt_file))
                    data['report_type'] = 'utilization'
                    all_data.append(data)
            
        except Exception as e:
            print(f"Error processing {rpt_file}: {e}")
            continue
    
    if not all_data:
        print("No data extracted from .rpt files")
        return
    
    # Convert to DataFrame and save as CSV
    df = pd.DataFrame(all_data)
    df.to_csv(output_csv, index=False)
    print(f"Data saved to {output_csv}")
    print(f"Total records: {len(df)}")
    
    # Print summary
    print("\nSummary:")
    print(f"Report types: {df['report_type'].value_counts().to_dict()}")
    print(f"Files processed: {df['file_name'].nunique()}")


def main():
    """Main function"""
    parser = argparse.ArgumentParser(description='Parse Vivado .rpt files and convert to CSV')
    parser.add_argument('input', help='Input .rpt file or directory containing .rpt files')
    parser.add_argument('-o', '--output', default='rpt_data.csv', help='Output CSV file (default: rpt_data.csv)')
    parser.add_argument('-t', '--type', choices=['all', 'timing', 'utilization'], 
                       default='all', help='Type of reports to process (default: all)')
    
    args = parser.parse_args()
    
    process_rpt_files(args.input, args.output, args.type)


if __name__ == "__main__":
    main()

