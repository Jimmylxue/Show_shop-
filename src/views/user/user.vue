<template>
  <div class="root">
    <!-- 面包屑导航 -->
    <el-breadcrumb separator-class="el-icon-arrow-right">
      <el-breadcrumb-item :to="{ path: '/main' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>用户管理</el-breadcrumb-item>
      <el-breadcrumb-item>用户列表</el-breadcrumb-item>
    </el-breadcrumb>
    <!-- 卡片 -->
    <el-card>
      <el-row :gutter="20">
        <el-col :span="8">
          <el-input v-model="search" placeholder="请输入用户ID">
            <el-button slot="append" icon="el-icon-search"></el-button>
          </el-input>
        </el-col>
        <el-col :span="6">
          <el-button type="primary" @click="dialogVisible = true">添加用户</el-button>
        </el-col>
      </el-row>
      <el-table :data="detailInfo" border stripe>
        <!-- el-table-column标签中 只要添加type="index" 就会自动添加索引列 -->
        <el-table-column type="index" label="#"></el-table-column>
        <el-table-column prop="userid" label="用户id"></el-table-column>
        <el-table-column prop="uname" label="用户名"></el-table-column>
        <el-table-column prop="userphone" label="电话"></el-table-column>
        <el-table-column prop="email" label="邮箱"></el-table-column>
        <el-table-column prop="role" label="角色"></el-table-column>
        <el-table-column label="操作" width="180px">
          <!-- 通过slot-scope="scope"可以拿到当前这行的信息 -->
          <template slot-scope="scope">
            <el-tooltip effect="dark" content="修改信息" placement="top" :enterable="false">
              <el-button
                type="primary"
                icon="el-icon-edit"
                size="mini"
                @click="editInfo(scope.row.userid)"
              ></el-button>
            </el-tooltip>
            <el-tooltip effect="dark" content="删除角色" placement="top" :enterable="false">
              <el-button
                type="danger"
                icon="el-icon-delete"
                size="mini"
                @click="delUser(scope.row.userid)"
              ></el-button>
            </el-tooltip>
            <el-tooltip effect="dark" content="分配角色" placement="top" :enterable="false">
              <el-button type="warning" icon="el-icon-setting" size="mini"></el-button>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>
      <el-dialog @close="dialogClose" title="添加用户" :visible.sync="dialogVisible" width="30%">
        <!--         
          此处有一个注意项  就是props的名字要和user里面的数据的名字一致
        -->
        <el-form :model="addUserInfo" :rules="addUserRules" ref="addDialog" label-width="70px">
          <el-form-item label="手机号" prop="phone">
            <el-input v-model="addUserInfo.phone"></el-input>
          </el-form-item>
          <el-form-item label="邮箱" prop="email">
            <el-input v-model="addUserInfo.email"></el-input>
          </el-form-item>
          <el-form-item label="密码" prop="userPwd">
            <el-input v-model="addUserInfo.userPwd"></el-input>
          </el-form-item>
          <el-form-item label="用户名" prop="userName">
            <el-input v-model="addUserInfo.userName"></el-input>
          </el-form-item>
          <el-form-item label="身份">
            <el-input v-model="addUserInfo.role" value="普通用户" disabled></el-input>
          </el-form-item>
        </el-form>
        <!-- 按钮区 -->
        <span slot="footer" class="dialog-footer">
          <el-button @click="dialogVisible = false">取 消</el-button>
          <el-button type="primary" @click="posttoserver">确 定</el-button>
        </span>
      </el-dialog>
      <!-- 修改用户信息的dialog -->
      <el-dialog title="修改信息" :visible.sync="editDialog" width="50%">
        <el-form :model="editUserInfo" :rules="addUserRules" ref="editDialog" label-width="70px">
          <el-form-item label="用户ID" prop="userid">
            <el-input v-model="editUserInfo.userid" disabled></el-input>
          </el-form-item>
          <el-form-item label="用户名" prop="uname">
            <el-input v-model="editUserInfo.uname"></el-input>
          </el-form-item>
          <el-form-item label="角色" prop="role">
            <el-input v-model="editUserInfo.role"></el-input>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="editDialog = false">取 消</el-button>
          <el-button type="primary" @click="edit">确 定</el-button>
        </span>
      </el-dialog>
    </el-card>
  </div>
</template>

<script>
import { mapActions } from 'vuex'
export default {
  data() {
    return {
      // 弹窗的显示
      dialogVisible: false,
      editDialog: false,
      detailInfo: [],
      editUserInfo: {},
      // 添加用户
      addUserInfo: {
        role: '普通用户',
        phone: '12345678',
        email: '12345678',
        userPwd: '12345678',
        userName: '12345678'
      },
      addUserRules: {
        userIds: [
          { required: true, message: '用户名不能为空', trigger: 'blur' },
          {
            min: 5,
            max: 10,
            message: '长度在 5 到 10 个字符',
            trigger: 'blur'
          }
        ],
        userPwd: [
          { required: true, message: '密码不能为空', trigger: 'blur' },
          {
            min: 6,
            max: 15,
            message: '长度在 6 到 15 个字符',
            trigger: 'blur'
          }
        ],
        userName: [
          { required: true, message: '用户名不能为空', trigger: 'blur' },
          {
            min: 6,
            max: 15,
            message: '长度在 6 到 15 个字符',
            trigger: 'blur'
          }
        ],
        email: [
          { required: true, message: '邮箱不能为空', trigger: 'blur' }
          // { validator: checkEmail, trigger: 'blur' },
        ],
        phone: [
          { required: true, message: '手机号不能为空', trigger: 'blur' }
          // { validator: checkPhone, trigger: 'blur' },
        ]
      },
      search: ''
    }
  },
  mounted() {
    this.getUsers()
  },
  watch: {},
  methods: {
    ...mapActions(['getUser', 'update', 'deleteUser', 'addUser']),
    // 关闭弹窗
    dialogClose() {},
    // 添加用户
    async posttoserver() {
      try {
        const code = await this.addUser(this.addUserInfo)
        if (code === 1) {
          this.$message({
            message: '用户添加成功',
            type: 'success'
          })
          this.getUsers()
        }
      } catch {
        this.$message.error('用户添加失败')
      }
      this.dialogVisible = !this.dialogVisible
    },
    // 获取用户列表
    async getUsers() {
      let res = await this.getUser()
      this.detailInfo = res
    },
    // 修改
    async edit() {
      console.log(this.editUserInfo)
      try {
        let code = await this.update(this.editUserInfo)
        if (code === 1) {
          this.$message({
            message: '更新成功',
            type: 'success'
          })
          this.getUsers()
        }
      } catch {
        this.$message.error('更新失败~请联系工作人员')
      }
      this.editDialog = !this.editDialog
    },
    editInfo(id) {
      this.editUserInfo = this.detailInfo.filter(item => (item.userid = id))[0]
      this.editDialog = !this.editDialog
    },
    // 删除用户
    async delUser(e) {
      try {
        let code = await this.deleteUser(e)
        if (code === 1) {
          this.$message({
            message: '删除成功',
            type: 'success'
          })
          this.getUsers()
        }
      } catch {
        this.$message.error('删除失败~')
      }
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
</style>
