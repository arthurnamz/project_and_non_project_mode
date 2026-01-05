# 2025-12-20T04:36:46.775875
import vitis

client = vitis.create_client()
client.set_workspace(path="software")

platform = client.create_platform_component(name = "platform",hw_design = "$COMPONENT_LOCATION/../../sim_lab/design_1_wrapper.xsa",os = "standalone",cpu = "microblaze_0",domain_name = "standalone_microblaze_0")

platform = client.get_component(name="platform")
status = platform.build()

comp = client.create_app_component(name="hello_world",platform = "$COMPONENT_LOCATION/../platform/export/platform/platform.xpfm",domain = "standalone_microblaze_0",template = "hello_world")

status = platform.build()

comp = client.get_component(name="hello_world")
comp.build()

status = platform.build()

comp.build()

