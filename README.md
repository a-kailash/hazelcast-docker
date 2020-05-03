# hazelcast-docker


I was intrested in running Hazelcast OSS as a distributed In Memory Cache. Reading up on existing blogs and guidance on Hazelcast, I realised that Hazelcast OSS provides limited features for security in the Open Source from.

Therefore I started to look at putting up multiple Hazelcast instances in docker and realised even here the existing blogs and guides on getting multiple containersed Hazelcast instances need updates. The key issue I found with existing blogs was in getting Hazelcast cluster members connecting with each other. It felt like it was time to do an updated version of Hazelcast in Docker Swarm





## References

* [Hazelcast IMDG Official Docker Images](https://hub.docker.com/r/hazelcast/hazelcast)
* [Hazelcast Management Centre Official Docker Images](https://hub.docker.com/r/hazelcast/hazelcast-jet-management-center)
* [Docker Compose v3.8 or above](https://docs.docker.com/compose/compose-file/)

## Dependencies:

* Docker CE v 19.03 or higher
* Docker Compose v3.8
* Vagrant and Virtualbox (If you want to bring up an isolated environment for this on your local machine)

## Docker Swarm based Network Isolated Hazelcast

### Run Hazelcast OSS on a private overlay network in Docker Swarm

#### Step 1 Docker CE Installed

You can bring up a Vagrant based Centos7 environment if you so choose. Although the Vagrantfile and Docker CE installation scripts are provided if needed,
the focus here is to bring up 3 Hazelcast Cluster members and all you need for the following steps is a working Docker CE v19.03 or higher environment

#### Step 2 Docker Swarm Init

Run command
```
    docker swarm init
```

#### Step 3 Create a Hazelcast Cluster as a Docker Stack

Run Docker stack deploy command
```
[vagrant@localhost hazelcast-v3]$ docker stack deploy -c hazelcast-v3.yml hc
Creating network hc_private_net
Creating service hc_hc-member3
Creating service hc_hc-member1
Creating service hc_hc-member2
```

Check the Docker services you created are in order

```
[vagrant@localhost hazelcast-v3]$ docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE                        PORTS
sy7uxdfj9lbl        hc_hc-member1       replicated          1/1                 hazelcast/hazelcast:3.11.7   
j38wct69ufxv        hc_hc-member2       replicated          1/1                 hazelcast/hazelcast:3.11.7   
rmo62pb4q0vn        hc_hc-member3       replicated          1/1                 hazelcast/hazelcast:3.11.7   
```

Docker the private overlay network exists

```
[vagrant@localhost hazelcast-v3]$ docker network ls -f "name=hc_private_net"
NETWORK ID          NAME                DRIVER              SCOPE
54kih4aziq7o        hc_private_net      overlay             swarm
```

All going well you should see a three member list coming up in thAe logs of anyone of the service instances as shown below:

```

vagrant@localhost hazelcast-v3]$docker service logs hc_hc-member1


hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | 
hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | Members {size:1, ver:1} [
hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | 	Member [10.0.3.2]:5701 - 46308f6d-d68b-421b-98ce-31c79fcab8a4 this
hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | ]
hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | 
hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | May 03, 2020 8:52:58 AM com.hazelcast.core.LifecycleService
hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | INFO: [10.0.3.2]:5701 [dev] [3.11.7] [10.0.3.2]:5701 is STARTED
hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | May 03, 2020 8:52:58 AM com.hazelcast.nio.tcp.TcpIpConnection
hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | INFO: [10.0.3.2]:5701 [dev] [3.11.7] Initialized new cluster connection between /10.0.3.2:5701 and /10.0.3.4:36206
hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | May 03, 2020 8:53:04 AM com.hazelcast.internal.cluster.ClusterService
hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | INFO: [10.0.3.2]:5701 [dev] [3.11.7] 
hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | 
hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | Members {size:2, ver:2} [
hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | 	Member [10.0.3.2]:5701 - 46308f6d-d68b-421b-98ce-31c79fcab8a4 this
hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | 	Member [10.0.3.4]:5701 - e4ee6c24-54b2-4676-838b-f896af5b2301
hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | ]
hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | 
hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | May 03, 2020 8:53:51 AM com.hazelcast.nio.tcp.TcpIpConnection
hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | INFO: [10.0.3.2]:5701 [dev] [3.11.7] Initialized new cluster connection between /10.0.3.2:5701 and /10.0.3.5:60079
hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | May 03, 2020 8:53:57 AM com.hazelcast.internal.cluster.ClusterService
hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | INFO: [10.0.3.2]:5701 [dev] [3.11.7] 
hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | 
hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | Members {size:3, ver:3} [
hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | 	Member [10.0.3.2]:5701 - 46308f6d-d68b-421b-98ce-31c79fcab8a4 this
hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | 	Member [10.0.3.4]:5701 - e4ee6c24-54b2-4676-838b-f896af5b2301
hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | 	Member [10.0.3.5]:5701 - 46af350f-f350-46d3-8a8f-d54bd47ad987
hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | ]
hc_hc-member1.1.xhmmgtlxw5eg@localhost.localdomain    | 

```
## Run Hazelcast Client application on two overlay Netwworks


