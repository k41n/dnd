class window.SkillLibrary
  constructor: (Skill, @$injector) ->
    @skills = {}
    skills = Skill.query {},  =>
      for skill in skills
        @skills[skill.id] = skill

  create: (id) ->
    console.log 'SkillLibrary create', id
    skill = @skills[id]
    if skill? && skill.js_class? && eval(skill.js_class)
      return new (eval(skill.js_class))(skill)
    else
      return new Skills.BaseAttack()



SkillLibrary.$inject = ["Skill", "$injector"]

angular.module("dndApp").service("SkillLibrary", SkillLibrary)