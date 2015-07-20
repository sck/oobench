package org.oobench.serialization;

class SerializationPerformanceComplexVersioned extends SerializationBenchmark {
    public static void main(String[] args) {
        showLocation();
        testSerialization(50000, SerializeClassComplexVersioned.class, 
                "complex serialization", args, 2, "using serialVersionUID");
    }
}
