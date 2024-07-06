# Local Storage

The project will be using local storage to ingest spacetrack and madrigal files. This comes at certain costs, such as RAM resource utilization and available disk space. As a result, performance will depend on each workstations persistent storage, DRAM, and for first time TLE data usage, network speed.

## Storage Structure
An environment variable `$DATA_ROOT` is set to determine the root directory of where the data files will be downloaded into. This env variables is defined as part of the `install.sh` script. You can use the command `change_root.sh` in the scripts directory to change `$DATA_ROOT`.

`install.sh` and `change_root.sh` both have the same functionality. A new directory called `SMD_DATA` is created. At the top level of `SMD_DATA`, there will be two more directories that will be created: `SPACETRACK`, and `MADRIGAL`. Each top level directory has its own storage structure.

### MADRIGAL

The following is a reflection of folder structure:

```yaml
MADRIGAL:
    INST_CAT:           # Instrument Category
        INST:           # Specific Instrument
            EXP:        # Specific Experiment
```

> The contents inside the directory is derived from source site metadata. Check reference document for data sources.

### SPACTRACK

The following is a reflection of the folder structure

```yaml
SPACETRACK:
    ENTITY:             # Entity Number / Entity Range
```

Prospective Folder Structure:

```yaml
SMD_DATA:
    MADRIGAL:
        INST_CAT:
            INST:
                EXP:
    SPACETRACK:
        ENTITY:
```

## Definition

>NOTE: FIX-ME --> Add outputs for `install.sh` and `change_root.sh`

### Example Definitions:

1. Defining `$DATA_ROOT` as part of install script

```bash
$ ./install.sh
$
```

2. Defining `$DATA_ROOT` post-install

```bash
$ cd post_install_scripts
$ ./change_root.sh
```




