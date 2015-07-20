package org.oobench.serialization;

class SerializationPerformanceComplex extends SerializationBenchmark {
    public static void main(String[] args) {
        showLocation();
        testSerialization(50000, SerializeClassComplex.class, 
                "complex serialization", args, 2, "");
    }
}
