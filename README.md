# ASUS VivoBook audio fix

Device-specific audio configuration for the ASUS VivoBook X530FN/S530FN: Intel Cannon Point-LP HDA controller `8086:9dc8`, ASUS subsystem `1043:1501`, and the ALC256 analog speaker path.

The PipeWire filter-chain adds a restrained low shelf, body, clarity, and air curve and exposes `Laptop Speakers - ASUS Natural`. A user service waits for PipeWire and makes that sink the default. It does not depend on EasyEffects.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/idruvau5/asus-vivobook-audio-fix/v0.1.0/install.sh -o /tmp/install-asus-audio.sh
bash /tmp/install-asus-audio.sh
```

The configuration is tuned for the laptop speakers; do not apply it to unrelated hardware without adjusting the EQ.
