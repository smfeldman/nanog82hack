# NANOG 82 Hackathon Project

Until recently, I was a member of the [NANOG](https://www.nanog.org/) Program Committee and helped to organize the [Hackathon](https://www.nanog.org/events/n82-hackathon/) events.
This time I joined as a participant!

I was unable to commit a specific amount of time to work on it, so instead of joining a team I set myself some modest initial goals intending to expand them as time permitted.

## Goals
Going in, my goals were to try to learn a little bit about the supplied Hackathon environment,  including:
- [Containerlab](https://containerlab.srlinux.dev/)
- Virtual [Arista](https://www.arista.com/en/products/software-controlled-container-networking) and [Nokia SR OS](https://containerlab.srlinux.dev/manual/kinds/vr-sros/) images
- gNMI and [pygnmi](https://github.com/akarneliuk/pygnmi)

Based on these learning goals, I came up with some simple project goals:
- Install [NetBox](https://netbox.readthedocs.io/en/stable/) or [Nautobot](https://nautobot.readthedocs.io/en/latest/) container in Containerlab
- Create some source of truth data in NetBox/Nautobot
- Create a Python script to update interface descriptions based on source of truth data, using NetBox/Nautobot and GNMI APIs.

## Shared host files in ContainerLab
I wanted a way to mount a host directory in the CentOS containers, to simplify code development and git access in the various environments.
To do this, I added these lines to the CentOS host entries in Containerlab configuration file:
```
      binds:
        - /home/team03/nanog82hack:/nanog82
```
## Nautobot Installation in Containerlab
Nautobot is a fork of NetBox with similar features, and the developers maintain a single container demo image.
To install this, I added these lines to the Containerlab configuration:
```
    nautobot:
      kind: linux
      image: networktocode/nautobot-lab
      mgmt_ipv4: 172.22.3.6
      mgmt_ipv6: 2001:172:22:3::6
      binds:
        - /home/team03/nanog82hack:/nanog82
      ports:
        - 8003:8000
```
Since this is also Linux-based, the  host directory `bind` also works.
This is useful for saving and restoring database backups.
## Source of truth data
Given the limited time, I just created simple entries for the two virtual routers and their interfaces:
![Nautobot devices](doc/nautobot-devices.png?raw=true "Devices in Nautobot")
![Nautobot ceos1 interfaces](doc/nautobot-ceos1.png?raw=true "ceos1 interfaces in Nautbot")

## Device update script

### Source of Truth: Nautobot API calls
Nautobot source of truth data is fetched using the [pynautobot](https://pynautobot.readthedocs.io/en/latest/) python package.

First, the device list is fetched:
```
    devices = nb.dcim.devices.all()
```
Then for each device meeting the criteria, the interface information is fetched:
```
    for device in devices:
        if str(device.status) == 'Active' and str(device.platform) == 'eos':
            interfaces = nb.dcim.interfaces.filter(device=device.name)
            descriptions= {}
            for interface in interfaces:
                descriptions[interface.name] = interface.description
```
### Device configuration changes: gNMI
cEOS was fairly easy:
```                update = [
                    (
                        f"openconfig-interfaces:interfaces/interface[name={interface}]",
                        {
                            "config": {
                                "description": description
                            }
                        }
                    )
                ]
                result = gc.set(update=update, encoding='json_ietf')
```
But SR OS was different, and I ran out of time to make it work.
### Source of Truth: Nautbot GraphQL API
[GraphQL](https://graphql.org/) is an alternative API query language, capable of expressing complex queries
across multiple resources.  These are processed on the server, returning only the desired results.

Using Nautobot's GraphQL API, the above set of queries is reduced to one:
```
    query = """
{
  devices(platform: "eos", status: "active") {
    name
    interfaces {
      name
      description
    }
  }
}
"""
    result = nb.graphql.query(query=query)
    for device in result.json['data']['devices']:
        descriptions= {}
        for interface in device['interfaces']:
            descriptions[interface['name']] = interface['description']
```
Note: This was done after the NANOG 82 Hackathon.

## Possible next steps
- Replicate Containerlab environment on my own hardware (in progress)
- GNMI/pygnmi on non-Arista images
- Juniper and/or Cisco images in containerlab
- Webhook receiver to push changes on demand
- Use ansible and/or nornir for device updates

