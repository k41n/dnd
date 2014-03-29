#= require spec_helper

describe 'CharacterModel', ->
  beforeEach ->
    @Skill = @model('Skill')
    @skills = [new @Skill({ id: 1, title: 'Удар ногой с разворота' })]
    @http.whenGET('/api/skills').respond(200, @skills)

    @character_data1 = 
      avatar_url: '/images/avatar.jpg'
      name: 'Character 1'      

    @character_data2 = 
      avatar_url: '/images/avatar2.jpg'
      name: 'Character 2'

    @CharacterModel = @factory('CharacterModel')
    console.log "@CharacterModel", @CharacterModel
    @char1 = @CharacterModel.new(@character_data1)
    @char2 = @CharacterModel.new(@character_data2)

  describe 'it loads services via DI', ->
    it 'loads SkillLibrary', ->
      expect(@char1.SkillLibrary).toBeDefined()

  describe 'loads permanent data', ->
    it 'accepts avatar url', ->
      expect(@char1.p.avatar_url).toEqual(@character_data1.avatar_url)

