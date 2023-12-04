const Item = require('../Item')
const httpMocks = require("node-mocks-http")
const app = require('../app')
const request = require("supertest")
const newTodo = require("./mock/post.json")


Item.create = jest.fn()
const endpointUrl = "/items"

describe('/items', () => { 
    test('POST should return status code 201', async () => { 
        const response = await request(app).post(endpointUrl).send(newTodo)
        expect(response.statusCode).toBe(201)
     })
     test('POST should return body.name same to newTodo.name', async () => { 
        const response = await request(app).post(endpointUrl).send(newTodo)
        expect(response.body.name).toBe(newTodo.name)
     })
})