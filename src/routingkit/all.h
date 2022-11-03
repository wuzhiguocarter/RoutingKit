#ifndef ROUTING_KIT_ALL_H
#define ROUTING_KIT_ALL_H

// generated by ~/RoutingKit$ find . -name "*.h"|sed 's/\.\/src\///g'|sed -E "s_(.*)_#include \"\1\"_"|grep -v all|sort 

#include "routingkit/base/bit_select.h"
#include "routingkit/base/bit_vector.h"
#include "routingkit/base/constants.h"
#include "routingkit/base/dijkstra.h"
#include "routingkit/base/emulate_gcc_builtin.h"
#include "routingkit/base/filter.h"
#include "routingkit/base/geo_dist.h"
#include "routingkit/base/graph_util.h"
#include "routingkit/base/id_mapper.h"
#include "routingkit/base/id_queue.h"
#include "routingkit/base/id_set_queue.h"
#include "routingkit/base/inverse_vector.h"
#include "routingkit/base/min_max.h"
#include "routingkit/base/permutation.h"
#include "routingkit/base/sort.h"
#include "routingkit/base/tag_map.h"
#include "routingkit/base/timestamp_flag.h"
#include "routingkit/base/verify.h"
#include "routingkit/core/contraction_hierarchy.h"
#include "routingkit/core/customizable_contraction_hierarchy.h"
#include "routingkit/core/geo_position_to_node.h"
#include "routingkit/core/nested_dissection.h"
#include "routingkit/core/strongly_connected_component.h"
#include "routingkit/utils/expect.h"
#include "routingkit/utils/osm/buffered_asynchronous_reader.h"
#include "routingkit/utils/osm/file_data_source.h"
#include "routingkit/utils/osm/osm_decoder.h"
#include "routingkit/utils/osm/osm_graph_builder.h"
#include "routingkit/utils/osm/osm_profile.h"
#include "routingkit/utils/osm/osm_simple.h"
#include "routingkit/utils/osm/protobuf.h"
#include "routingkit/utils/timer.h"
#include "routingkit/utils/vector_io.h"



#endif