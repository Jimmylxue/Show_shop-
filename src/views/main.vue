<template>
  <div class="my">
    <div class="textContainer">
      <h2>Show_Shop</h2>
      <h3>专注于线上购物，用心做商品，用服务温暖他人！</h3>
    </div>
  </div>
</template>

<script>
export default {}
</script>

<style lang="less" scope>
* {
  margin: 0;
  padding: 0;
}
.my {
  width: 100%;
  height: 100%;
  background: url('../assets/img/bg2.png');
  display: flex;
  justify-content: center;
  .textContainer {
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 800px;
    // height: 300px;
    // border: 1px solid black;
    color: white;
    margin-top: 100px;
    h3 {
      padding-top: 40px;
    }
  }
}
</style>
