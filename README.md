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

### Source of Truth: Nautobot REST API calls
- pynautobot
(put examples here)
### Device configuration changes: gNMI
- cEOS was fairly easy
- SR OS was different, I ran out of time.
### Source of Truth: Nautbot GraphQL API
- explain GraphQL
- pynautobot
(put examples here)

## Possible next steps
- Replicate Containerlab environment on my own hardware
- GNMI/pygnmi on non-Arista images
- Juniper and/or Cisco images in containerlab
- Webhook receiver to push changes on demand
- Use ansible and/or nornir for device updates

