# CMPT 470: Milestone 4: Static Analysis with Infer
## Tech Titans: Gson Analysis

## Overview
This project runs Infer static analysis on the Gson library inside a Docker container.
Everything is automated, dependencies, Infer, and Gson are all set up inside the container.

---

## Setup

### 1. Build the Docker image
```
docker build -t infer-gson .
```
This will take a few minutes the first time.
Added  platform flag for Macbook

### 2. Run the container
```
docker run -it --name m4 infer-gson bash
```
You will be inside the container when you see `root@...:/m4/gson#`

---

## Running Infer Analysis

**Important:** The normal `infer run -- mvn` command does NOT work with Gson
due to a known incompatibility with Gson's module-info.java file.
Use the following steps instead:

### Step 1 - Navigate to the gson submodule
```
cd /m4/gson/gson
```

### Step 2 - Build Gson
```
mvn clean compile -DskipTests
```

### Step 3 - Get dependencies
```
CP=$(find ~/.m2 -name "*.jar" | tr '\n' ':')
```

### Step 4 - Run Infer
```
time infer run -- javac -cp "$CP" -source 11 -target 11 \
  $(find src/main/java -name "*.java" ! -name "module-info.java") \
  $(find target/generated-sources -name "*.java")
```

### Expected Output
```
Found 14 issues
Thread Safety Violation: 14
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
