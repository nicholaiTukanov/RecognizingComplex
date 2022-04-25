module attributes {tf.versions = {bad_consumers = [], min_consumer = 12 : i32, producer = 987 : i32}}  {
  func @main() {
    tf_executor.graph {
      %outputs, %control = tf_executor.island wraps "tf.Const"() {device = "", value = dense<3> : tensor<2xi32>} : () -> tensor<2xi32>
      %outputs_0, %control_1 = tf_executor.island wraps "tf.RandomUniform"(%outputs) {device = "", seed = 0 : i64, seed2 = 0 : i64} : (tensor<2xi32>) -> tensor<3x3xf32>
      %outputs_2, %control_3 = tf_executor.island wraps "tf.Const"() {device = "", value = dense<3> : tensor<2xi32>} : () -> tensor<2xi32>
      %outputs_4, %control_5 = tf_executor.island wraps "tf.RandomUniform"(%outputs_2) {device = "", seed = 0 : i64, seed2 = 0 : i64} : (tensor<2xi32>) -> tensor<3x3xf32>
      %outputs_6, %control_7 = tf_executor.island wraps "tf.Complex"(%outputs_0, %outputs_4) {device = ""} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xcomplex<f32>>
      %outputs_8, %control_9 = tf_executor.island wraps "tf.Const"() {device = "", value = dense<3> : tensor<2xi32>} : () -> tensor<2xi32>
      %outputs_10, %control_11 = tf_executor.island wraps "tf.RandomUniform"(%outputs_8) {device = "", seed = 0 : i64, seed2 = 0 : i64} : (tensor<2xi32>) -> tensor<3x3xf32>
      %outputs_12, %control_13 = tf_executor.island wraps "tf.Const"() {device = "", value = dense<3> : tensor<2xi32>} : () -> tensor<2xi32>
      %outputs_14, %control_15 = tf_executor.island wraps "tf.RandomUniform"(%outputs_12) {device = "", seed = 0 : i64, seed2 = 0 : i64} : (tensor<2xi32>) -> tensor<3x3xf32>
      %outputs_16, %control_17 = tf_executor.island wraps "tf.Complex"(%outputs_10, %outputs_14) {device = ""} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xcomplex<f32>>
      %outputs_18, %control_19 = tf_executor.island wraps "tf.Const"() {device = "", value = dense<3> : tensor<2xi32>} : () -> tensor<2xi32>
      %outputs_20, %control_21 = tf_executor.island wraps "tf.RandomUniform"(%outputs_18) {device = "", seed = 0 : i64, seed2 = 0 : i64} : (tensor<2xi32>) -> tensor<3x3xf32>
      %outputs_22, %control_23 = tf_executor.island wraps "tf.Const"() {device = "", value = dense<3> : tensor<2xi32>} : () -> tensor<2xi32>
      %outputs_24, %control_25 = tf_executor.island wraps "tf.RandomUniform"(%outputs_22) {device = "", seed = 0 : i64, seed2 = 0 : i64} : (tensor<2xi32>) -> tensor<3x3xf32>
      %outputs_26, %control_27 = tf_executor.island wraps "tf.Complex"(%outputs_20, %outputs_24) {device = ""} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xcomplex<f32>>
      %outputs_28, %control_29 = tf_executor.island wraps "tf.Identity"(%outputs_26) {device = ""} : (tensor<3x3xcomplex<f32>>) -> tensor<3x3xcomplex<f32>>
      %outputs_30, %control_31 = tf_executor.island wraps "tf.PartitionedCall"(%outputs_6, %outputs_16, %outputs_26) {_collective_manager_ids = [], _read_only_resource_inputs = [], config = "", config_proto = "\0A\07\0A\03CPU\10\01\0A\07\0A\03GPU\10\002\02J\008\01\82\01\00", device = "", executor_type = "", f = @__inference_cgemm_direct_390} : (tensor<3x3xcomplex<f32>>, tensor<3x3xcomplex<f32>>, tensor<3x3xcomplex<f32>>) -> tensor<3x3xcomplex<f32>>
      tf_executor.fetch
    }
    return
  }
  func private @__inference_cgemm_direct_390(%arg0: tensor<3x3xcomplex<f32>> {tf._user_specified_name = "A"}, %arg1: tensor<3x3xcomplex<f32>> {tf._user_specified_name = "B"}, %arg2: tensor<3x3xcomplex<f32>> {tf._user_specified_name = "C"}) -> tensor<3x3xcomplex<f32>> attributes {tf._construction_context = "kEagerRuntime"} {
    %0 = tf_executor.graph {
      %outputs, %control = tf_executor.island wraps "tf.Imag"(%arg0) {device = ""} : (tensor<3x3xcomplex<f32>>) -> tensor<3x3xf32>
      %outputs_0, %control_1 = tf_executor.island wraps "tf.Real"(%arg0) {device = ""} : (tensor<3x3xcomplex<f32>>) -> tensor<3x3xf32>
      %outputs_2, %control_3 = tf_executor.island wraps "tf.Imag"(%arg1) {device = ""} : (tensor<3x3xcomplex<f32>>) -> tensor<3x3xf32>
      %outputs_4, %control_5 = tf_executor.island wraps "tf.MatMul"(%outputs, %outputs_2) {device = "", transpose_a = false, transpose_b = false} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xf32>
      %outputs_6, %control_7 = tf_executor.island wraps "tf.MatMul"(%outputs_0, %outputs_2) {device = "", transpose_a = false, transpose_b = false} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xf32>
      %outputs_8, %control_9 = tf_executor.island wraps "tf.Real"(%arg1) {device = ""} : (tensor<3x3xcomplex<f32>>) -> tensor<3x3xf32>
      %outputs_10, %control_11 = tf_executor.island wraps "tf.MatMul"(%outputs_0, %outputs_8) {device = "", transpose_a = false, transpose_b = false} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xf32>
      %outputs_12, %control_13 = tf_executor.island wraps "tf.Sub"(%outputs_10, %outputs_4) {device = ""} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xf32>
      %outputs_14, %control_15 = tf_executor.island wraps "tf.MatMul"(%outputs, %outputs_8) {device = "", transpose_a = false, transpose_b = false} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xf32>
      %outputs_16, %control_17 = tf_executor.island wraps "tf.AddV2"(%outputs_6, %outputs_14) {device = ""} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xf32>
      %outputs_18, %control_19 = tf_executor.island wraps "tf.Imag"(%arg2) {device = ""} : (tensor<3x3xcomplex<f32>>) -> tensor<3x3xf32>
      %outputs_20, %control_21 = tf_executor.island wraps "tf.AddV2"(%outputs_16, %outputs_18) {device = ""} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xf32>
      %outputs_22, %control_23 = tf_executor.island wraps "tf.Real"(%arg2) {device = ""} : (tensor<3x3xcomplex<f32>>) -> tensor<3x3xf32>
      %outputs_24, %control_25 = tf_executor.island wraps "tf.AddV2"(%outputs_12, %outputs_22) {device = ""} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xf32>
      %outputs_26, %control_27 = tf_executor.island wraps "tf.Complex"(%outputs_24, %outputs_20) {device = ""} : (tensor<3x3xf32>, tensor<3x3xf32>) -> tensor<3x3xcomplex<f32>>
      %outputs_28, %control_29 = tf_executor.island wraps "tf.Identity"(%outputs_26) {device = ""} : (tensor<3x3xcomplex<f32>>) -> tensor<3x3xcomplex<f32>>
      tf_executor.fetch %outputs_28 : tensor<3x3xcomplex<f32>>
    }
    return %0 : tensor<3x3xcomplex<f32>>
  }
}
