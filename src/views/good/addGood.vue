<template>
  <div class="root addGoods">
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/main' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>商品管理</el-breadcrumb-item>
      <el-breadcrumb-item>添加商品</el-breadcrumb-item>
    </el-breadcrumb>
    <el-card>
      <div class="imgs">
        <img
          v-for="(item,index) in goodimg"
          :key="index"
          :src="item"
          ref="goodimg"
          width="200px"
          height="200px"
          alt
        />
        <div class="fa fa-plus fa-2x" aria-hidden="true">
          <input type="file" @change="changeimg" class="file" />
        </div>
      </div>
      <el-form
        :label-position="labelPosition"
        label-width="80px"
        :rules="rules"
        ref="good"
        :model="good"
      >
        <el-form-item label="商品名称" prop="name">
          <el-input v-model="good.name"></el-input>
        </el-form-item>
        <el-form-item label="商品描述" prop="desc">
          <el-input type="textarea" v-model="good.desc"></el-input>
        </el-form-item>
        <el-form-item label="商品价格" prop="price">
          <el-input v-model="good.price"></el-input>
        </el-form-item>
        <el-form-item label="所属分类" prop="classify">
          <el-select @change="selChassify" v-model="good.classify" placeholder="请选择">
            <el-option
              v-for="item in classOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="所属品牌" prop="brand">
          <el-select @change="selBrand" v-model="good.brand" placeholder="请选择">
            <el-option
              v-for="item in brandOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            ></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="商品规格" prop="capacity">
          <el-input v-model="good.capacity"></el-input>
        </el-form-item>
        <el-form-item label="是否包邮" class="freight">
          <el-radio-group v-model="radio1">
            <el-radio-button label="是"></el-radio-button>
            <el-radio-button label="否"></el-radio-button>
          </el-radio-group>
          <el-input v-show="radio1==='否'" v-model="good.freight" placeholder="请输入具体的邮费"></el-input>
        </el-form-item>
        <el-form-item label="二手产品">
          <el-radio-group v-model="good.type">
            <el-radio-button label="是"></el-radio-button>
            <el-radio-button label="否"></el-radio-button>
          </el-radio-group>
        </el-form-item>
        <el-button class="add" @click="add('good')" type="primary">立即添加</el-button>
      </el-form>
    </el-card>
  </div>
</template>

<script>
import { mapActions } from 'vuex'
export default {
  data() {
    return {
      labelPosition: 'right',
      // 包邮的flag
      radio1: '是',
      good: {
        name: '小米AI音箱',
        desc:
          '说出小爱同学，就能唤醒它，让它给你播音乐、给宝宝讲故事、叫你起床、为你选择去公司最快捷的交通方式，甚至还能控制家里的智能设备。不仅如此，你还可以训练它，让它越来越聪明，越来越懂你。',
        price: 229,
        classify: '',
        brand: '',
        // 规格
        capacity: '官方标配',
        // 是否二手
        type: '是',
        // 邮费
        freight: 0,
        imgname: '',
        imgsrc: ''
      },
      rules: {
        name: [
          { required: true, message: '请输入商品名称', trigger: 'blur' },
          { min: 4, max: 12, message: '长度在 4 到 12 个字符', trigger: 'blur' }
        ],
        desc: [
          { required: true, message: '请输入商品描述', trigger: 'blur' },
          {
            min: 20,
            max: 300,
            message: '长度在 20 到 300 个字符',
            trigger: 'blur'
          }
        ],
        price: [{ required: true, message: '请输入商品价格', trigger: 'blur' }],
        classify: [
          { required: true, message: '请选择商品分类', trigger: 'blur' }
        ],
        brand: [
          { required: true, message: '请输入商品品牌', trigger: 'blur' },
          { min: 2, max: 99, message: '请输入正确的品牌名称', trigger: 'blur' }
        ],
        capacity: [
          { required: true, message: '请输入商品规格', trigger: 'blur' },
          { min: 3, max: 5, message: '长度在 3 到 5 个字符', trigger: 'blur' }
        ]
      },

      classOptions: [
        {
          value: 1,
          label: '手机'
        },
        {
          value: 2,
          label: '电脑'
        },
        {
          value: 3,
          label: '耳机'
        }
      ],
      brandOptions: [
        {
          value: 1,
          label: '华为'
        },
        {
          value: 2,
          label: '小米'
        },
        {
          value: 3,
          label: '苹果'
        }
      ],
      goodimg: [],
      lab: ''
    }
  },
  watch: {
    radio1(newval) {
      if (newval === '是') {
        this.good.freight = 0
        return
      }
    }
  },
  methods: {
    ...mapActions(['addGood']),
    // 提交图片
    changeimg(e) {
      const files = e.target.files[0]
      const render = new FileReader()
      let imgFile
      render.readAsDataURL(files)
      render.onload = e => {
        imgFile = e.target.result
        const arr = imgFile.split(',')
        this.goodimg.push(imgFile)
        this.good.imgname = arr[0]
        this.good.imgsrc = arr[1]
      }
    },

    //选择类型
    selChassify(e) {
      // 默认传递一个参数 这个参数就是遍历的数据数组的value值
      this.good.classify = this.classOptions.filter(
        item => item.value === e
      )[0].label
    },
    // 选择品牌
    selBrand(e) {
      this.good.brand = this.classOptions.filter(
        item => item.value === e
      )[0].label
    },

    // 提交
    add(good) {
      this.$refs[good].validate(valid => {
        if (valid) {
          if (this.good.imgsrc !== '' && this.good.imgname !== '') {
            this.addGood(this.good)
            this.$message({
              showClose: true,
              message: '商品添加成功',
              type: 'success'
            })
            return
          }
          this.$message({
            message: '只有上传了图片，用户才能够更好的选购哦~',
            type: 'warning'
          })
        } else {
          console.log('error submit!!')
          return false
        }
      })
    }
  }
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
  margin: 30px 0 0px 0;
  display: flex;
  img {
    margin-right: 20px;
  }
  div {
    width: 200px;
    height: 200px;
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
