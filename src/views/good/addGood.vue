<template>
  <div class="root addGoods">
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/main' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>商品管理</el-breadcrumb-item>
      <el-breadcrumb-item>添加商品</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <div class="imgs">
        <img src="@/assets/logo.png" width="250px" height="250px" alt="" />
        <div class="fa fa-plus fa-2x" aria-hidden="true">
          <input type="file" class="file" />
        </div>
      </div>
      <el-form
        :label-position="labelPosition"
        label-width="80px"
        :model="formLabelAlign"
      >
        <el-form-item label="商品名称">
          <el-input v-model="formLabelAlign.name"></el-input>
        </el-form-item>
        <el-form-item label="商品描述">
          <el-input type="textarea" v-model="formLabelAlign.name"></el-input>
        </el-form-item>
        <el-form-item label="商品价格">
          <el-input v-model="formLabelAlign.type"></el-input>
        </el-form-item>
        <el-form-item label="所属分类">
          <el-select v-model="name" placeholder="请选择">
            <el-option
              v-for="item in classOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="所属品牌">
          <el-select v-model="name" placeholder="请选择">
            <el-option
              v-for="item in brandOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            >
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="商品规格">
          <el-input v-model="formLabelAlign.type"></el-input>
        </el-form-item>
        <el-form-item label="二手产品">
          <el-radio-group v-model="formLabelAlign.radio1">
            <el-radio-button label="是"></el-radio-button>
            <el-radio-button label="否"></el-radio-button>
          </el-radio-group>
        </el-form-item>
        <el-button class="add" type="primary">立即添加</el-button>
      </el-form>
    </el-card>
  </div>
</template>

<script>
export default {
  data() {
    return {
      labelPosition: 'right',
      formLabelAlign: {
        name: '',
        region: '',
        type: '',
        radio1: '是',
      },
      classOptions: [
        {
          value: '选项1',
          label: '手机',
        },
        {
          value: '选项2',
          label: '电脑',
        },
        {
          value: '选项3',
          label: '耳机',
        },
      ],
      brandOptions: [
        {
          value: '选项1',
          label: '华为',
        },
        {
          value: '选项2',
          label: '小米',
        },
        {
          value: '选项3',
          label: '苹果',
        },
      ],
    }
  },
}
</script>

<style lang="less" scoped>
.root {
  padding: 20px;
}
.el-card {
  margin-top: 15px;
  .el-table {
    margin-top: 15px;
  }
}
.imgs {
  width: 100%;
  height: 250px;
  // background-color: #2ecc71;
  margin: 30px 0 50px 0;
  display: flex;
  img {
    margin-right: 20px;
  }
  div {
    width: 250px;
    height: 250px;
    border: 1px dashed rgb(228, 228, 228);
    color: rgb(228, 228, 228);
    display: flex;
    justify-content: center;
    align-items: center;
    font-weight: 100;
    position: relative;
    .file {
      display: block;
      width: 100%;
      height: 100%;
      position: absolute;
      opacity: 0;
    }
  }
}
.add {
  width: 200px;
}
</style>
