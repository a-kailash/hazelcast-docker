
# Deloying a Hazelcast V3 based 3 member cluster on Docker Swarm


#### Step 1 Docker CE Installed

You can bring up a Vagrant based Centos7 environment if you so choose. Although the Vagrantfile and Docker CE installation scripts are provided if needed,
the focus here is to bring up 3 Hazelcast Cluster members and all you need for the following steps is a working Docker CE v19.03 or higher environment

#### Step 2 Docker Swarm Init

Run command
```
    docker swarm init
```

#### Step 3 Create a Hazelcast Cluster as a Docker Stack

Make sure you are in the correct dir

```
cd hazelcast-v4
```

Run Docker stack deploy command
```
[vagrant@localhost hazelcast-v4]$ docker stack deploy -c hazelcast-v4.yml hc
Creating network hc_private_net
Creating service hc_hc4-member3
Creating service hc_hc4-member1
Creating service hc_hc4-member2
```

Check the Docker services you created are in order

```
[vagrant@localhost hazelcast-v4]$ docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE                       PORTS
kw5cb4hs06om        hc_hc4-member1      replicated          1/1                 hazelcast/hazelcast:4.0.1   
e7v8vuqrow7l        hc_hc4-member2      replicated          1/1                 hazelcast/hazelcast:4.0.1   
inzmrb7x8vl2        hc_hc4-member3      replicated          1/1                 hazelcast/hazelcast:4.0.1   
```

Docker the private overlay network exists

```
[vagrant@localhost hazelcast-v3]$ docker network ls -f "name=hc_private_net"
NETWORK ID          NAME                DRIVER              SCOPE
54kih4aziq7o        hc_private_net      overlay             swarm
```

All going well you should see a three member list coming up in thAe logs of anyone of the service instances as shown below:

```
[vagrant@localhost hazelcast-v4]$ docker service logs hc_hc4-member2

hc_hc4-member2.1.qofurudb5f9g@localhost.localdomain    | May 03, 2020 5:27:03 PM com.hazelcast.internal.cluster.impl.TcpIpJoiner
hc_hc4-member2.1.qofurudb5f9g@localhost.localdomain    | INFO: [hc4-member2]:5711 [dev] [4.0.1] [hc4-member1]:5712 is added to the blacklist.
hc_hc4-member2.1.qofurudb5f9g@localhost.localdomain    | May 03, 2020 5:27:03 PM com.hazelcast.internal.nio.tcp.TcpIpConnection
hc_hc4-member2.1.qofurudb5f9g@localhost.localdomain    | INFO: [hc4-member2]:5711 [dev] [4.0.1] Initialized new cluster connection between /10.0.3.6:38437 and hc4-member1/10.0.3.4:5711
hc_hc4-member2.1.qofurudb5f9g@localhost.localdomain    | May 03, 2020 5:27:03 PM com.hazelcast.internal.nio.tcp.TcpIpConnection
hc_hc4-member2.1.qofurudb5f9g@localhost.localdomain    | INFO: [hc4-member2]:5711 [dev] [4.0.1] Initialized new cluster connection between /10.0.3.6:39270 and hc4-member3/10.0.3.2:5711
hc_hc4-member2.1.qofurudb5f9g@localhost.localdomain    | May 03, 2020 5:27:09 PM com.hazelcast.internal.cluster.ClusterService
hc_hc4-member2.1.qofurudb5f9g@localhost.localdomain    | INFO: [hc4-member2]:5711 [dev] [4.0.1] 
hc_hc4-member2.1.qofurudb5f9g@localhost.localdomain    | 
hc_hc4-member2.1.qofurudb5f9g@localhost.localdomain    | Members {size:3, ver:3} [
hc_hc4-member2.1.qofurudb5f9g@localhost.localdomain    | 	Member [hc4-member1]:5711 - 9940e073-937c-4688-a359-386b21f94b05
hc_hc4-member2.1.qofurudb5f9g@localhost.localdomain    | 	Member [hc4-member3]:5711 - 31c84efc-c478-4385-a15a-306bdb46973a
hc_hc4-member2.1.qofurudb5f9g@localhost.localdomain    | 	Member [hc4-member2]:5711 - d61ed68f-dede-43cf-9580-c08cfbc437eb this
hc_hc4-member2.1.qofurudb5f9g@localhost.localdomain    | ]
hc_hc4-member2.1.qofurudb5f9g@localhost.localdomain    | 
hc_hc4-member2.1.qofurudb5f9g@localhost.localdomain    | May 03, 2020 5:27:10 PM com.hazelcast.core.LifecycleService
hc_hc4-member2.1.qofurudb5f9g@localhost.localdomain    | INFO: [hc4-member2]:5711 [dev] [4.0.1] [hc4-member2]:5711 is STARTED

```

## Run Hazelcast Client application on two overlay Netwworks

TODO

