package org.oobench.serialization;

class SerializationPerformanceSimpleVersioned extends SerializationBenchmark {
    public static void main(String[] args) {
        showLocation();
        testSerialization(50000, SerializeClassSimpleVersioned.class, 
                "simple serialization", args, 1, "using serialVersionUID");
    }
}
