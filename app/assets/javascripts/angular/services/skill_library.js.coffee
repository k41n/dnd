class window.SkillLibrary
  constructor: (Skill, @$injector) ->
    @skills = {}
    skills = Skill.query {},  =>
      for skill in skills
        @skills[skill.id] = skill

  create: (id) ->
    console.log 'SkillLibrary create', id
    skill = @skills[id]
    if skill?
      return new (eval(skill.js_class))(skill)



SkillLibrary.$inject = ["Skill", "$injector"]

angular.module("dndApp").service("SkillLibrary", SkillLibrary)