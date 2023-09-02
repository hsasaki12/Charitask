module QuestsHelper
  def quest_status_i18n(quest)
    I18n.t("enums.quest.status.#{quest.status}", default: quest.status)
  end

  def quest_difficulty_i18n(quest)
    I18n.t("enums.quest.difficulty.#{quest.difficulty}", default: quest.difficulty)
  end
end
