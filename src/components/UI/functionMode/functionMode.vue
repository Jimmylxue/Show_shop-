<template>
  <div class="functionMode">
    <div class="mine">
      <el-card class="conts">
        <div class="user">
          <div class="header">
            <img src="@/assets/img/portrait.jpg" width="100%" height="100%" alt />
          </div>
          <!-- <div class="name">{{name===''?'请登录':name}}</div> -->
        </div>
        <div class="more">
          <div
            v-for="(item,index) in checkList"
            v-show="item.status == 1"
            :key="index"
            class="firstline"
          >
            <i @click="del(item.id)" class="el-icon-delete"></i>
            <img :src="item.img" alt />
            <span>{{item.functionName}}</span>
          </div>
        </div>
      </el-card>
    </div>
    <div class="functionContainer">
      <el-card>
        <h3>功能模块</h3>
        <el-checkbox-group v-model="arr" @change="changeStatus">
          <el-checkbox
            v-for="(item,index) in checkList"
            :key="index"
            :label="item.functionName"
            :checked="item.status==1"
          ></el-checkbox>
          <!-- <el-checkbox></el-checkbox> -->
        </el-checkbox-group>
        <div class="addMode">
          <div class="form">
            <el-form>
              <el-form-item label="名称">
                <el-input v-model="addMsg.functionName" placeholder="请输入功能"></el-input>
              </el-form-item>
              <el-form-item label="图片">
                <div>
                  <img v-show="addMsg.img" width="150px" height="150px" :src="addMsg.img" alt />
                </div>

                <div @click="showImg" class="add">
                  <i class="el-icon-plus"></i>
                </div>
              </el-form-item>
              <el-form-item label="连接地址">
                <el-input v-model="addMsg.url" placeholder="请输入功能地址"></el-input>
              </el-form-item>
            </el-form>
          </div>
        </div>
        <hr style="color:#ccc" />
        <div class="btn">
          <el-button class="btns" @click="add" type="success">确定</el-button>
        </div>
      </el-card>
    </div>
    <img-load v-show="addFlag" @hasSelect="getImg" @out="closeImg"></img-load>
  </div>
</template>

<script>
import imgLoad from '@/components/imgLoad/imgLoad.vue'
export default {
  components: {
    imgLoad
  },
  data() {
    return {
      checkList: [],
      arr: [],
      addFlag: false,
      addMsg: {
        functionName: '',
        url: ''
      }
    }
  },
  mounted() {
    this.getFunctions()
  },
  methods: {
    async getFunctions() {
      let res = await this.$api.functionsMode.getFunctions()
      this.checkList = res.data
    },
    async changeStatus(value) {
      let ids = ''
      value.map(item => {
        console.log(item)
        let arr = this.checkList.filter(items => {
          return items.functionName == item
        })
        console.log(arr)
        ids += arr[0].id + '@'
      })
      ids = ids.slice(0, -1)
      let params = {}
      params.ids = ids
      let res = await this.$api.functionsMode.changeFunctionStatus(params)
      if (res.data.code == 200) {
        this.$swal('哟吼~', '修改成功~', 'success')
        this.getFunctions()
        return
      }
      this.$swal('哟吼~', res.data.result, 'error')
    },
    showImg() {
      this.addFlag = true
    },
    getImg(img) {
      this.addMsg.img = img[0]
      console.log(img)
      console.log(this.addMsg.img)
    },
    closeImg() {
      this.addFlag = false
    },
    async add() {
      let params = this.addMsg
      let res = await this.$api.functionsMode.addFunction(params)
      if (res.data.code == 200) {
        this.$swal('哟吼~', '添加成功~', 'success')
        this.getFunctions()
        return
      }
      this.$swal('哟吼~', res.data.result, 'error')
    },
    async del(id) {
      let params = {}
      params.id = id

      this.$swal({
        title: '您确定要删除这个功能吗？',
        text: '删除后将无法恢复，请谨慎操作！',
        type: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#dd6b55',
        confirmButtonText: '是的,我要删除',
        cancelButtonText: '容我三思',
        dangerMode: true
      }).then(willDelete => {
        if (willDelete.value) {
          this.$api.functionsMode.delFunction(params).then(res => {
            console.log(res)
            if (res.data.code == 200) {
              this.$swal('哟吼~', '删除成功~', 'success')
              this.getFunctions()
              return
            }
            this.$swal('哟吼~', res.data.result, 'error')
          })
        }
      })
    }
  }
}
</script>

<style lang="less" scoped>
.functionMode {
  display: flex;
}
.mine {
  width: 300px;
  // height: 200px;
  .conts {
    height: 500px;
    display: flex;
    flex-direction: column;
    .user {
      width: 100%;
      height: 120px;
      border-bottom: 1px solid #ccc;
      display: flex;
      justify-content: center;
      align-items: center;
      .header {
        width: 70px;
        height: 70px;
        border-radius: 50%;
        overflow: hidden;
        margin-right: 1rem;
      }
      .name {
        font-size: 1.8rem;
      }
    }
    .more {
      width: 100%;
      // height: 100%;
      // border: 1px solid #ccc;
      display: flex;
      justify-content: space-between;
      flex-wrap: wrap;
      .firstline {
        margin-top: 20px;
        position: relative;

        i {
          position: absolute;
          right: 1px;
          top: 1px;
          display: none;
        }
        &:hover > i {
          display: block;
        }
      }
      div {
        height: 80px;
        display: flex;
        padding: 5px 10px;
        flex-direction: column;
        // align-items: center;
        text-align: center;
        // margin-top: 8px;
        img {
          width: 45px;
          height: 45px;
        }
        span {
          padding-bottom: 8px;
          padding-top: 5px;
          font-size: 0.9rem;
          color: rgb(42, 48, 56);
        }
        &:hover {
          border: 1px solid #ccc;
          box-shadow: 0 0 5px #ccc;
        }
      }
    }
    .more::after {
      content: '';
      width: 65px;
    }
  }
}
.functionContainer {
  width: 100%;
  h3 {
    margin-bottom: 15px;
  }
}
.form {
  display: flex;
  justify-content: center;
  .el-form {
    width: 50%;
    .add {
      width: 150px;
      height: 150px;
      position: relative;
      display: flex;
      justify-content: center;
      align-items: center;
      border: 1px dashed #ccc;
      i {
        position: absolute;
        font-size: 22px;
      }
    }
  }
}
.btn {
  display: flex;
  justify-content: center;
  margin-top: 20px;
  .btns {
    width: 100px;
  }
}
</style>