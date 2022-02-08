package com.ares.test;

import org.junit.Test;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import reactor.test.StepVerifier;

import java.util.Arrays;
import java.util.List;
import java.util.concurrent.CompletableFuture;

/**
 * @description:
 * @author: Young
 * @date: 2021/03/01
 * @see: com.ares.test.leetcode SpringReactorTest.java
 **/
public class SpringReactorTest {

    @Test
    public void createAFlux_just() {
        Flux<String> flux = Flux.just("1", "2", "3");
        flux.subscribe(f -> System.out.println("Here`s some number:" + f)
                , error -> System.out.println(error)
                , () -> System.out.println("run"));
        StepVerifier.create(flux)
                .expectNext("1")
                .expectNext("2")
                .expectNext("3")
                .verifyComplete();

    }

    @Test
    public void testMono() {
        Mono<String> mono = Mono.create(monoSink -> System.out.println(monoSink.currentContext()));
        mono.subscribe(a -> System.out.println(a));
    }


    @Test
    public void test() {
        String a = "a", b = "b", c = "c";
        CompletableFuture future = CompletableFuture.supplyAsync(() -> {
            System.out.println(a);
            return Arrays.asList("A", "B", "C");
        });
        future.thenApplyAsync(o -> {
            List<String> list = (List<String>) o;
            System.out.println(list.size());
            return list.get(0);
        });
        future.thenAcceptAsync(o -> {
            System.out.println(o);
        });

    }
}
