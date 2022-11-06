#include "routingkit/base/bit_vector.h"
#include "routingkit/base/id_mapper.h"
#include "routingkit/base/filter.h"
#include "routingkit/utils/expect.h"
#include <iostream>
#include <vector>

using namespace RoutingKit;
using namespace std;

int main(int argc, char*argv[]){
    vector<string> names = {"Bob", "Alice", "Charlie", "Malice"};
    BitVector keep_filter = make_bit_vector(names.size(), [&](unsigned i){return !(names[i][0] == 'A' || names[i][1] == 'a');});
    vector<string> filtered_names = keep_element_of_vector_if(keep_filter, names);

    LocalIDMapper map(keep_filter);
    for(unsigned i=0; i<names.size(); ++i){
        if(keep_filter.is_set(i))
            assert(filtered_names[map.to_local(i)] == names[i]); 
    }
    return 0;
}