import { createApp } from 'vue'
import App from './App.vue'
import { store, key } from './store'
import { VueWindowSizePlugin } from 'vue-window-size/option-api';

const app = createApp(App)
app.use(store, key)
app.use(VueWindowSizePlugin);
app.mount('#app')
