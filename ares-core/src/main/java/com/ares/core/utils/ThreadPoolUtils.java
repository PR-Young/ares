/*
 * !******************************************************************************
 *  * Copyright (c) 2021 - 9999, ARES
 *  *
 *  * Licensed under the Apache License, Version 2.0 (the "License");
 *  * you may not use this file except in compliance with the License.
 *  * You may obtain a copy of the License at
 *  *
 *  *        http://www.apache.org/licenses/LICENSE-2.0
 *  *
 *  * Unless required by applicable law or agreed to in writing, software
 *  * distributed under the License is distributed on an "AS IS" BASIS,
 *  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  * See the License for the specific language governing permissions and
 *  * limitations under the License.
 *  *****************************************************************************
 */

package com.ares.core.utils;

import java.util.concurrent.*;

/**
 * @description:
 * @author: Young 2020/05/08
 **/
public final class ThreadPoolUtils {
    private ThreadPoolUtils() {
    }

    public static final ExecutorService CACHED_THREAD_POOL = Executors.newCachedThreadPool();

    public static final ExecutorService FIXED_THREAD_POOL = Executors.newFixedThreadPool(5);

    public static final ExecutorService SINGLE_THREAD_POOL = Executors.newSingleThreadExecutor();

    public static final ExecutorService EXECUTOR_SERVICE = new ThreadPoolExecutor(5,
            10,
            0,
            TimeUnit.SECONDS,
            new ArrayBlockingQueue<>(512),
            new ThreadPoolExecutor.DiscardPolicy());

    public static final ExecutorService SINGLE_EXECUTOR_SERVICE = new ThreadPoolExecutor(1,
            1,
            0,
            TimeUnit.SECONDS,
            new ArrayBlockingQueue<>(10),
            new ThreadPoolExecutor.DiscardPolicy());
}
