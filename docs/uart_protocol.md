# UART Telemetry Protocol

Transport: 115200 baud, 8 data bits, no parity, 1 stop bit.

Each frame is a newline-terminated list of comma-separated key/value pairs:

```text
SPD=72,SOC=81,V=384.6,A=62.4,MT=49.2,IT=43.5,BT=32.1,RNG=188,GEAR=D,MODE=ECO,CHG=0,L=1,R=0,HEAD=1,REGEN=0.0,FAULT=
```

Supported fields:

| Key | Meaning | Unit |
| --- | --- | --- |
| SPD | Vehicle speed | km/h |
| SOC | Battery state of charge | % |
| V | Pack voltage | V |
| A | Pack current | A |
| MT | Motor temperature | C |
| IT | Inverter temperature | C |
| BT | Battery temperature | C |
| RNG | Estimated range | km |
| GEAR | P, R, N, D | text |
| MODE | Drive mode | text |
| CHG | Charging state, 0 or 1 | bool |
| L | Left indicator, 0 or 1 | bool |
| R | Right indicator, 0 or 1 | bool |
| HEAD | Headlight state, 0 or 1 | bool |
| REGEN | Regeneration power | kW |
| FAULT | Optional warning text | text |

Parser behavior:

- Unknown fields are ignored.
- Missing fields keep their previous values.
- Invalid or empty frames are rejected without changing the model.
- The UI binds only to `VehicleData`, keeping serial parsing isolated from QML.
