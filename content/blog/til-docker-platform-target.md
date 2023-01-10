---
publishDate: "2023-01-10"
title: "TIL: Setting Custom Platfom Target for Building Docker Containers"
categories: ["til", "tech", "docker"]
image: "posts/docker-build-help.webp"
---

# Today I Learned

...about setting a custom platform target when building Docker Containers.

## Background

As a machine learning engineer, I often deal with building different C/C++ libraries. For my job, I use an Apple M1 Mac, and I often run into weird compatibilities issues.

The default CPU architecture for the longest time was `x86_64`. When compiling software, you need to take into account the OS and the CPU architecture. With the release of the M1, Apple switched the CPU architecture from `x86_64` to `arm`. There are plenty of better posts comparing and contrasting these two architectures. But to make a long story short, this change has made working with compiled software more programmatic.

## Problem

For local development, I often use [Homebrew](https://brew.sh/) to manage dependencies. One of the systems I have to work with is [Kafka](https://kafka.apache.org/), and the library I used to connect to a Kafka cluster is `confluent-kafka`, which has a dependency on `librdkafka-dev`. This is the dependcy that will give me issues.

For CI, every job is run in an [OCI container](https://www.docker.com/resources/what-container/). The most popular tool to manage containers is [Docker](https://www.docker.com/). So, I was using docker to try and simulate what CI would be doing with my code. However, I kept getting errors.

My base image layer was Debian, and the install script kept saying that `librdkafka-dev` was not supported on the current version of Debian. This did not make sense when I looked at indexed Debian packages and new that `librdkafka-dev` was supported.

## Solution

After about 2 hours, I noticed that debian packages were being listed in my terminal with `arm` next to them. I realized the problem was that docker noticed that the host (my laptop) was `arm` based and assumed that was what I wanted the container to be. But the container had to be built with `x86_64` in mind since that was the target chipset for `librdkafka-dev` and that library does not support ARM.

Instead of trying to get another machine and run the same code or build from scratch, I noticed that `docker build` can provide the fix I needed. We can manually set the target platform to for the container to be run on.

Instead of executing the following in my terminal

```bash
docker build -t <my container image>:<tag> .

```

I ran

```bash
docker build --platform linux/amd64 -t <my container image>:<tag> .
```

The most important part is the second half of the `--platform` flag: `amd64` is just another name for `x86_64`.

## Conclusion

Apple M1 Macs (and Amazon EC2 Instances powered by Graviton3 chips) proved `arm` chips are here to stay in modern computing and developers will be using them. Although Apple has done a good job with documentation and dev tooling to support libraries and apps built for `x86_64`, it is still on library and app maintainers/developers to ensure their software can be built/run on different chipsets. If not, they need to document which platforms their software is supported. However, sometimes downstream devs can get around this limitation and tools like `docker build --platform` could help.
