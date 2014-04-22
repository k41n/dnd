class window.SkillLibrary
  constructor: (Skill, @$injector) ->
    @skills = {}
    @loading = Skill.query {},  =>
      for skill in @loading
        @skills[skill.id] = @build(skill)

  create: (id) ->
    skill = @skills[id]
    @build(skill)

  build: (skill) ->
    if skill? && skill.js_class? && eval(skill.js_class)
      return new (eval(skill.js_class))(skill)
    else
      return new Skills.BaseAttack(skill)

  getById: (id) ->
    @skills[id]

  getByJsClass: (jsClass) ->
    for i, skill of @skills
      return skill if skill.js_class == jsClass

SkillLibrary.$inject = ["Skill", "$injector"]

angular.module("dndApp").service("SkillLibrary", SkillLibrary)