import mongodb from 'mongodb'

export default {
  port: 3000,
  mongoUrl: 'mongodb://localhost:27017/slack-clone',
  // "port": process.env.PORT,
  // "mongoUrl": process.env.MONGODB_URI,
  bodyLimit: '100kb',
}
