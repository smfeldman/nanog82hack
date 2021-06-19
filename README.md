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

## Nautobot Installation in Containerlab
## Shared host files in ContainerLab
## Source of truth data
Given the limited time, I just created simple entries for the two virtual routers and their interfaces:
![Nautobot devices](doc/nautbot-devices.png?raw=true "Devices in Nautobot")
![Nautobot ceos1 interfaces](doc/nautbot-ceos1-interfaces.png?raw=true "ceos1 interfaces in Nautbot")

## Device update script
