#accesses = [
  affine_map<(m) -> (m)>,
  affine_map<(m) -> (m)>
]

#attrs = {
  indexing_maps = #accesses,
  iterator_types = ["parallel"]
}

// memory layouts
#identity = affine_map<(d0) -> (d0)>

func.func @example(%A: memref<?xf32, #identity>,
              %B: memref<?xvector<4xf32>, offset: 1, strides: [2]>) {
  linalg.generic #attrs
  ins(%A: memref<?xf32, #identity>)
  outs(%B: memref<?xvector<4xf32>, offset: 1, strides: [2]>) {
  ^bb0(%a: f32, %b: vector<4xf32>):
    %c = "some_compute"(%a, %b): (f32, vector<4xf32>) -> (vector<4xf32>)
    linalg.yield %c: vector<4xf32>
  }
  return
}


