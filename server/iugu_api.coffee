Iugu = {}

class Iugu.API

  #
  # Create a new IuguApi
  # Pass the api_token as parameter
  #
  constructor: (@api_token) ->
    check @api_token, String
    @base_url = 'https://api.iugu.com/v1/'

  #
  # Internal
  #
  check_for_errors: (ret) ->
    if ret.data.errors && !ret.data.sucess == 'true'
      throw new Meteor.Error(ret.statusCode, EJSON.stringify(ret.data.errors))
    ret.data

  #
  # Create a new customer
  #
  create_customer: (email, name, notes) ->
    ret = HTTP.post @base_url + 'customers',
      auth: @api_token + ':'
      params:
        email: email
        name: name
        notes: notes
    @check_for_errors(ret)

  #
  # Remove customer
  #
  remove_customer: (id) ->
    check id, String
    ret = HTTP.del @base_url + 'customers/' + id,
      auth: @api_token + ':'
    @check_for_errors(ret)

  #
  # Return a list of customers
  #
  customers: ->
    ret = HTTP.get @base_url + 'customers',
      auth: @api_token + ':'
    @check_for_errors(ret).items

  #
  # Create a new payment method for a customer
  #
  create_payment_method: (customer_id, description, options) ->
    check customer_id, String
    check description, String
    options.customer_id = customer_id
    options.description = description
    ret = HTTP.post @base_url + 'customers/' + customer_id + '/payment_methods',
      auth: @api_token + ':'
      params: options
    @check_for_errors(ret)

  #
  # Create a new Payment Token from a credit card
  #
  create_payment_token: (account_id, number, first_name, last_name, cvv, month, year) ->
    check account_id, String
    check number, String
    check first_name, String
    check last_name, String
    check cvv, String
    check month, String
    check year, String
    ret = HTTP.post @base_url + 'payment_token',
      auth: @api_token + ':'
      params:
        account_id: account_id
        method: 'credit_card'
        'data[number]': number
        'data[verification_value]': cvv
        'data[first_name]': first_name
        'data[last_name]': last_name
        'data[month]': month
        'data[year]': year
    @check_for_errors(ret).id

  #
  # Create a new invoice
  #
  create_invoice: (email, due_date, options) ->
    check email, String
    check due_date, String
    options.email = email
    options.due_date =  due_date

    ret = HTTP.post @base_url + 'invoices',
      auth: @api_token + ':'
      data: options
    @check_for_errors(ret)

  #
  # Return a list of invoices
  #
  invoices: ->
    ret = HTTP.get @base_url + 'invoices',
      auth: @api_token + ':'
    @check_for_errors(ret).items

  #
  # Remove invoice
  #
  remove_invoice: (id) ->
    check id, String
    ret = HTTP.del @base_url + 'invoices/' + id,
      auth: @api_token + ':'
    @check_for_errors(ret)


  #
  # Charge an invoice to a customer payment method
  #
  charge: (options) ->
    ret = HTTP.post @base_url + 'charge',
      auth: @api_token + ':'
      data: options
    @check_for_errors(ret)

  charge_bank_slip: (email, description, quantity, value_cents) ->
    ret = HTTP.post @base_url + 'charge',
      auth: @api_token + ':'
      params:
        method: 'bank_slip'
        email: email
        "items[][description]": description
        "items[][quantity]": quantity
        "items[][price_cents]": value_cents
    @check_for_errors ret
