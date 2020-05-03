# hazelcast-docker


I was intrested in running Hazelcast OSS as a distributed In Memory Cache. Reading up on existing blogs and guidance on Hazelcast, I realised that Hazelcast OSS provides limited features for security in the Open Source from.

Therefore I started to look at putting up multiple Hazelcast instances in docker and realised even here the existing blogs and guides on getting multiple containersed Hazelcast instances need updates. The key issue I found with existing blogs was in getting Hazelcast cluster members connecting with each other. It felt like it was time to do an updated version of Hazelcast in Docker Swarm

## Run Hazelcast OSS on a private overlay network in Docker Swarm


