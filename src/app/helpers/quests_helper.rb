module QuestsHelper
    def quest_status_i18n(quest)
      I18n.t("enums.quest.status.#{quest.status}")
    end
  end
  