import axios from 'axios'

let csrf = document.querySelector('meta[name="csrf-token"]').content
axios.defaults.headers['X-CSRF-TOKEN'] = csrf

export default axios
