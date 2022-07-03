require 'swagger_helper'

RSpec.describe 'quotes_controller', type: :request do

  path '/quotes' do

    get('list all quotes') do
      response(200, 'successful') do
        produces 'application/json'
        parameter name: :quote, in: :body, schema: {
          type: :object,
          properties: {
            content: { type: :string },
            author: { type: :string }
          },
          required: %w[content author]
        }


        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create quote') do
      response(200, 'successful') do
        consumes 'application/json'
        parameter name: :quote, in: :body, schema: {
          type: :object,
          properties: {
            content: { type: :string },
            author: { type: :string }
          },
          required: ['content', 'author']
        }


        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/quotes/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show quote') do
      response(200, 'successful') do
        schema type: :object,
        properties: {
          id: { type: :integer, },
          author: { type: :string },
          content: { type: :string },
        },
        required: [ 'id', 'author', 'content' ]
        let(:id) { Quote.create(author: "bobby", content: "oops!") }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    # skipping patch b/c both content and author are validated/required.
    # patch('update quote') do
    #   response(200, 'successful') do
    #     produces 'application/json'
    #     consumes 'application/json'
    #     parameter name: :quote, in: :body, schema: {
    #       type: :object,
    #       properties: {
    #         content: { type: :string },
    #         author: { type: :string }
    #       },
    #       required: ['id']
    #     }
        
    #     after do |example|
    #       example.metadata[:response][:content] = {
    #         'application/json' => {
    #           example: JSON.parse(response.body, symbolize_names: true)
    #         }
    #       }
    #     end
    #     run_test!
    #   end
    # end

    put('update quote') do
      response(200, 'successful') do
        produces 'application/json'
        consumes 'application/json'
        parameter name: :quote, in: :body, schema: {
          type: :object,
          properties: {
            content: { type: :string },
            author: { type: :string }
          },
          required: ['id', 'content', 'author']
        }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete quote') do
      response(200, 'successful') do
        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
