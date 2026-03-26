\# Experiment 1: Tool Setup and Configuration

\*\*Chibuikem Emeka-Nwuba\*\*



\## Installation Method and Infer Version

Infer v1.1.0 was installed using the official binary release from GitHub. 

Since Infer does not run natively on Windows, WSL2 (Windows Subsystem for Linux) 

was configured with Ubuntu 24.04. The binary was extracted to 

/opt/infer-linux64-v1.1.0/ and added to PATH via \~/.bashrc.



Verification:

infer --version

Output: Infer version v1.1.0



\## Operating System

Windows 11 with WSL2 running Ubuntu 24.04

Linux kernel: 6.6.87.2-microsoft-standard-wsl2



\## Java Version

openjdk version "21.0.10" 2026-01-20

OpenJDK Runtime Environment (build 21.0.10+7-Ubuntu-124.04)



\## Build Tool and Version

Apache Maven 3.8.7



\## Repository URL and Commit

URL: https://github.com/google/gson



\## Total Lines of Code

10,277 lines of Java code across 86 source files (core module)

Measured using cloc \~/gson/gson/src/main/java



\## Build Verification

Command: mvn clean package -DskipTests

Result: 7/8 modules SUCCESS

Failed module: Gson Protobuf Support (requires Maven 3.9.6, system has 3.8.7)



\## Setup Challenges



\### Challenge 1 - Docker registries inaccessible

All known Infer Docker registries were attempted:

\- gcr.io/infer-base/infer — blocked (requires Google authentication)

\- ghcr.io/facebook/infer — access denied

\- fbinfer/infer on Docker Hub — does not exist

Resolution: Switched to native Linux binary installation inside WSL2.



\### Challenge 2 - Infer Maven compiler conflict

When running infer run -- mvn, Infer substituted its own older Maven 

compiler plugin (3.8.0) which was incompatible with Gson's build.

Resolution: Used direct javac invocation excluding module-info.java:



infer run -- javac -cp "$CP" -source 11 -target 11 \\

&#x20; $(find src/main/java -name "\*.java" ! -name "module-info.java") \\

&#x20; $(find target/generated-sources -name "\*.java")

