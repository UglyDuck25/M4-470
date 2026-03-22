# Chut — Experiment Outputs

All validations assume the core `gson` module is already built (`mvn clean compile -DskipTests` under `/m4/gson/gson`).
Semgrep runs were executed after reproducibility validation of other team members' work.

---

## Experiment 6.5: Comparison with Semgrep

See [semgrep/6.5.md](semgrep/6.5.md) for full results, tool comparison table, and discussion.

---

## Experiment 6.2 & 6.3: Infer Validation (extras & proto modules)

### extras module

```bash
cd /m4/gson/extras

mvn dependency:copy -Dartifact=javax.annotation:javax.annotation-api:1.3.2 -DoutputDirectory=/tmp/deps

CP="/m4/gson/gson/target/classes:/tmp/deps/javax.annotation-api-1.3.2.jar:$(find ~/.m2 -name '*.jar' | tr '\n' ':')"

time infer run -- javac -cp "$CP" -source 11 -target 11 \
  $(find src/main/java -name "*.java" ! -name "module-info.java")
```

---

### proto module

```bash
cd /m4/gson/proto

mvn dependency:copy -Dartifact=com.google.protobuf:protobuf-java:3.25.3:jar -DoutputDirectory=/tmp/deps

CP="/m4/gson/gson/target/classes:/tmp/deps/javax.annotation-api-1.3.2.jar:/tmp/deps/protobuf-java-3.25.3.jar:$(find ~/.m2 -name '*.jar' | tr '\n' ':')"

time infer run -- javac -cp "$CP" -source 11 -target 11 \
  $(find src/main/java -name "*.java" ! -name "module-info.java")
```