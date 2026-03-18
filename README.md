# Installation Guide

## CMPT 470 – Static Analysis with Infer

This assignment is designed to be performed **inside a Docker container** on a Linux OS. The container handles all setup, including dependencies, Infer installation, and the Gson repository.

### Features

- Installs all necessary dependencies:
  - `curl`, `git`, `maven`, `make`, `cloc`, `sqlite3`, `xz-utils`, `zlib1g-dev`, `openjdk-17-jdk-headless`
- Installs the **latest version of Infer** (v1.2.0)
- Clones the **Gson repository**
- Builds Gson and runs static analysis using Infer
- Captures environment details and project metrics (LOC, commit hash, Java/Maven version)

---

### Usage

1. **Build the Docker image**:

```bash
docker build -t m4-470 .
```

2. **Run the Docker container interactively, mounting the Gson directory for easy access**:
```bash
docker run -it -v /gson:/gson m4-470:latest /bin/bash
```
- it → interactive terminal
- v /gson:/gson → mounts your local /gson directory to /gson inside the container

3. **Inside the Container**
## Navigate to the cloned repository:
```bash
cd /gson
ls
```

## Verify Infer installation:
```bash
infer --version
```

## Build Gson and run Infer analysis manually (if needed):
```bash
mvn clean install
infer run -- mvn clean install
```
### Generated Output Files
The container automatically generates the following files for reproducibility and analysis:
- commit_hash.txt → current Git commit hash of Gson
- os_info.txt → OS information
- java_version.txt → installed Java version
- maven_version.txt → Maven version
- repo_url.txt → URL of the cloned repository
- loc.txt → lines of code summary

### Notes

- Ensure Docker is installed and running on your system.
- All steps, including Infer installation and environment setup, are automated inside the container.
- Use the interactive container shell to perform testing or further static analysis as needed.
