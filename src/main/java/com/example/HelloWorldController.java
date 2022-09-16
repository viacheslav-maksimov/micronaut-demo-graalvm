package com.example;

import io.micronaut.http.MediaType;
import io.micronaut.http.annotation.Controller;
import io.micronaut.http.annotation.Get;
import jakarta.inject.Inject;
import org.redisson.api.RedissonClient;

@Controller("/helloworld")
public class HelloWorldController {
    @Inject
    private RedissonClient redissonClient;
    private static final String TEXT = "Hello, World!";

    @Get(value = "/", produces = MediaType.TEXT_PLAIN)
    public String getPlainText() {
        return TEXT;
    }
}