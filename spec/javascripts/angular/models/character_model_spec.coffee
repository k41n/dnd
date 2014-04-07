#= require spec_helper
#= require fixtures/api

describe 'CharacterModel', ->
  beforeEach ->
    stubApiPerks(@http)
    stubApiSkills(@http)
    stubApiWeapons(@http)
    stubApiRaces(@http)
    stubApiCharacterClasses(@http)
    stubApiCharacterAbilities(@http)

    @Skill = @model('Skill')
    @skills = [new @Skill({ id: 1, title: 'Удар ногой с разворота' })]
    @http.whenGET('/api/skills').respond(200, @skills)


    @character_data1 = 
      avatar_url: '/images/avatar.jpg'
      name: 'Character 1'
      character_class_id: 1

    @character_data2 = 
      avatar_url: '/images/avatar2.jpg'
      name: 'Character 2'
      character_class_id: 1

    @CharacterModel = @factory('CharacterModel')

    @http.flush()

    @char1 = @CharacterModel.new(@character_data1)
    @char2 = @CharacterModel.new(@character_data2)


  describe 'it loads services via DI', ->
    it 'loads SkillLibrary', ->
      expect(@char1.SkillLibrary).toBeDefined()

  describe 'loads permanent data', ->
    it 'accepts avatar url', ->
      expect(@char1.p.avatar_url).toEqual(@character_data1.avatar_url)


