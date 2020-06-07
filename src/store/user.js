import user from '../service/user'

export default {
  state: {
    editState: 0,
    deleteState: 0,
    addState: 0,
  },
  mutations: {
    changeEditState(state, value) {
      state.editState = value
    },
    changeDeleteState(state, value) {
      state.deleteState = value
    },
    changeAddState(state, value) {
      state.addState = value
    },
  },
  actions: {
    async getUser() {
      return await (await user.getUser()).data
    },
    async update({ commit }, e) {
      let { code } = await (await user.update(e)).data
      console.log(code)
      commit('changeEditState', code)
      return code
    },
    async deleteUser({ commit }, id) {
      let { code } = await (await user.deleteUser(id)).data
      commit('changeDeleteState', code)
      return code
    },
    async addUser({ commit }, msg) {
      let { code } = await (await user.addUser(msg)).data
      commit('changeAddState', code)
      return code
    },
  },
  getters: {},
}
