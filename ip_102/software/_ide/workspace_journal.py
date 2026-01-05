# 2025-12-09T05:42:07.070801
import vitis

client = vitis.create_client()
client.set_workspace(path="software")

platform = client.create_platform_component(name = "platform",hw_design = "$COMPONENT_LOCATION/../../project_1/design_1_wrapper.xsa",os = "standalone",cpu = "microblaze_0",domain_name = "standalone_microblaze_0")

