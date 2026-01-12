# 2026-01-05T05:11:30.665789
import vitis

client = vitis.create_client()
client.set_workspace(path="sw")

platform = client.get_component(name="platform")
status = platform.build()

comp = client.get_component(name="hello_world")
comp.build()

