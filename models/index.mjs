import {Sequelize, DataTypes} from 'sequelize';
import userModel from '../models/userModel.mjs'; 
import dotenv from 'dotenv';
import pg from 'pg';


const Pool = pg.Pool

dotenv.config(); 

const DATABASE_URL = process.env.POSTGRES_URL

const dialectOptions = {};

if (process.env.CA_CERT) {
  dialectOptions.ssl = {
    require: true,
    ca: process.env.CA_CERT.replace(/\\n/g, '\n')
  };
} else if (process.env.NODE_ENV === 'production') {
  dialectOptions.ssl = {
    require: true,
    rejectUnauthorized: false
  };
}

const sequelize = new Sequelize(DATABASE_URL, {
  dialect: "postgres",
  dialectOptions: dialectOptions,
  define: {
    schema: 'public',
  },
});

// For local database
// const sequelize = new Sequelize(
//   process.env.POSTGRES_DATABASE,
//   process.env.POSTGRES_USER,
//   process.env.POSTGRES_PASSWORD,
//   {
//     host: process.env.POSTGRES_HOST,
//     port: 43425,
//     dialect: "postgres",
//     dialectOptions: {},
//     define: {
//       schema: 'public',
//     },
//   }
// );


    sequelize.authenticate().then(() => {
        console.log(`Database connected`)
    }).catch((err) => {
        console.log(err)
    })

    const db = {}
    db.Sequelize = Sequelize
    db.sequelize = sequelize

db.users = userModel(sequelize, DataTypes)

export default db