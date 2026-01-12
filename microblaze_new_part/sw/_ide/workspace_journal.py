# 2026-01-06T06:25:52.085360
import vitis

client = vitis.create_client()
client.set_workspace(path="sw")

client.delete_component(name="platform")

platform = client.create_platform_component(name = "platform_new",hw_design = "$COMPONENT_LOCATION/../../hw/project_1/design_1_wrapper.xsa",os = "standalone",cpu = "microblaze_0",domain_name = "standalone_microblaze_0")

platform = client.get_component(name="platform_new")
status = platform.build()

status = platform.build()

comp = client.get_component(name="hello_world")
comp.build()

