import parse from 'pg-connection-string';
const url = "postgres://user:pass@host/db?sslmode=require";
const parsed = parse.parse(url);
console.log(parsed);
