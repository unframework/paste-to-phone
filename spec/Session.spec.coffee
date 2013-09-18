
Session = require './../src/Session'
events = require 'events'

describe 'Session', ->

  beforeEach ->
    @session = new Session()

  describe 'after adding first client', ->
    beforeEach ->
      @firstMessageStream = new events.EventEmitter
      @firstMessageStream.write = jasmine.createSpy 'First Client'

      @session.addClient @firstMessageStream

    it 'should send client count to new client', ->
      expect(@firstMessageStream.write).toHaveBeenCalledWith '1'

    it 'should send client count to next client and first client', ->
      @secondMessageStream = new events.EventEmitter
      @secondMessageStream.write = jasmine.createSpy()
      @session.addClient @secondMessageStream

      expect(@firstMessageStream.write).toHaveBeenCalledWith '2'
      expect(@secondMessageStream.write).toHaveBeenCalledWith '2'

    it 'should send data to all clients other than sender', ->
      @secondMessageStream = new events.EventEmitter
      @secondMessageStream.write = jasmine.createSpy 'Second Client'
      @session.addClient @secondMessageStream

      @thirdMessageStream = new events.EventEmitter
      @thirdMessageStream.write = jasmine.createSpy 'Third Client'
      @session.addClient @thirdMessageStream

      @firstMessageStream.emit 'data', 'Hello 1234'

      expect(@firstMessageStream.write).not.toHaveBeenCalledWith 'Hello 1234'
      expect(@secondMessageStream.write).toHaveBeenCalledWith 'Hello 1234'
      expect(@thirdMessageStream.write).toHaveBeenCalledWith 'Hello 1234'

    it 'should clean up on disconnect', ->
      @secondMessageStream = new events.EventEmitter
      @secondMessageStream.write = jasmine.createSpy 'Second Client'
      @session.addClient @secondMessageStream

      @secondMessageStream.emit 'end'

      @thirdMessageStream = new events.EventEmitter
      @thirdMessageStream.write = jasmine.createSpy 'Third Client'
      @session.addClient @thirdMessageStream

      expect(@thirdMessageStream.write).toHaveBeenCalledWith '2'
