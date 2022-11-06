# Graph Representation
[toc]

## Representations
### arc-list
RoutingKit supports any graph representable under this form. This includes border cases such as graphs with multi-arc, loops, disconnected graphs, or zero-weights. If a RoutingKit function does not properly behave given these inputs then we consider it a bug.
```c++
unsigned node_count; // count of graph nodes
std::vector<unsigned>tail; // index: arc ID, value: tail node of arc
std::vector<unsigned>head; // index: arc ID, value: head node of arc
```
addtional properties of arc
```c++
std::vector<unsigned>geo_distance; // geographical distances in meter
std::vector<unsigned>travel_time;  // travel times in seconds
std::vector<unsigned>speed;        // speeds in km/h
```

### adjacency-array
for: graph traversal
```c++
std::vector<unsigned>first_out; // index: node ID, value: first outgoing arc of node
std::vector<unsigned>head;      // index: arc ID, value: head node of arc
```

```c++
for(unsigned xy=first_out[x]; xy<first_out[x+1]; ++xy){
	unsigned y = head[xy];
	// xy is the arc from node x to node y
}
```

邻接矩阵的csr/csc编码
![](https://images0.cnblogs.com/blog/354318/201502/042300502345067.png)

### transform
#### adjacency array to arc list

```c++
unsigned node_count = first_out.size()-1;
auto tail = invert_inverse_vector(first_out);
```

#### arc list to adjacency array
```c++
auto input_arc_id = compute_sort_permutation_using_less(tail);
tail = apply_permutation(input_arc_id, tail);
head = apply_permutation(input_arc_id, head);
travel_time = apply_permutation(input_arc_id, travel_time);
auto first_out = invert_vector(tail, node_count);
```

## BitVector, IDMapper and Filter

查询处理器支持的指令集
```bash
(base) ➜  ~ sysctl -a|grep machdep.cpu.features
machdep.cpu.features: FPU VME DE PSE TSC MSR PAE MCE CX8 APIC SEP MTRR PGE MCA CMOV PAT PSE36 CLFSH DS ACPI MMX FXSR SSE SSE2 SS HTT TM PBE SSE3 PCLMULQDQ DTES64 MON DSCPL VMX SMX EST TM2 SSSE3 FMA CX16 TPR PDCM SSE4.1 SSE4.2 x2APIC MOVBE POPCNT AES PCID XSAVE OSXSAVE SEGLIM64 TSCTMR AVX1.0 RDRAND F16C
```

## OSM Routing Graph

```c++
SimpleOSMCarRoutingGraph simple_load_osm_car_routing_graph_from_pbf(
    const std::string&pbf_file, 
    const std::function<void(const std::string&)>&log_message = nullptr, 
    bool all_modelling_nodes_are_routing_nodes = false, 
    bool file_is_ordered_even_though_file_header_says_that_it_is_unordered = false
);
```

```c++
struct SimpleOSMCarRoutingGraph{
  std::vector<unsigned>first_out;
  std::vector<unsigned>head;
  std::vector<unsigned>travel_time;
  std::vector<unsigned>geo_distance;
  std::vector<float>latitude;
  std::vector<float>longitude;
  std::vector<unsigned>forbidden_turn_from_arc;
  std::vector<unsigned>forbidden_turn_to_arc;

  unsigned node_count()const;
  unsigned arc_count()const;
};
```

```c++
struct OSMRoutingGraph{
	std::vector<unsigned>first_out;
	std::vector<unsigned>head;
	std::vector<unsigned>way;
	std::vector<unsigned>geo_distance;
	std::vector<float>latitude;
	std::vector<float>longitude;
	std::vector<bool>is_arc_antiparallel_to_way;

	std::vector<unsigned>forbidden_turn_from_arc;
	std::vector<unsigned>forbidden_turn_to_arc;

	std::vector<unsigned>first_modelling_node;
	std::vector<float>modelling_node_latitude;
	std::vector<float>modelling_node_longitude;

	unsigned node_count()const;
	unsigned arc_count()const;
};
```

```c++
enum class OSMWayDirectionCategory{
  open_in_both,
  only_open_forwards,
  only_open_backwards,
  closed
};
using OnewayClassifierFunc std::function<
	OSMWayDirectionCategory(
		uint64_t osm_way_id, 
		unsigned routing_way_id, 
		const TagMap&way_tags
	)
>;

enum class OSMTurnRestrictionCategory{
  mandatory,
  prohibitive
};
struct OSMTurnRestriction{
  uint64_t osm_relation_id;
  OSMTurnRestrictionCategory category;
  uint64_t from_way;
  uint64_t via_node;
  uint64_t to_way;
};
using TurnRestrictionClassifierFunc std::function<
    void(
		
      uint64_t osm_relation_id, 
      const std::vector<OSMRelationMember>&member_list, 
      const TagMap&tags, 
      std::function<void(OSMTurnRestriction)>on_new_turn_restriction
    )
>;
OSMRoutingGraph load_osm_routing_graph_from_pbf(
  const std::string&pbf_file,
  const OSMRoutingIDMapping&mapping,
  OnewayClassifierFunc oneway_classifier,
  TurnRestrictionClassifierFunc turn_restriction_classifier,
  std::function<void(const std::string&)>log_message = nullptr,
  bool file_is_ordered_even_though_file_header_says_that_it_is_unordered = false,
  OSMRoadGeometry geometry_to_be_extracted = OSMRoadGeometry::none
);
```