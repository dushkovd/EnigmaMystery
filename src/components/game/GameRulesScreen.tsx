import React from 'react';
import { motion } from 'framer-motion';
import { useLanguage } from '../../context/LanguageContext';

const GameRulesScreen: React.FC = () => {
  const { t, language } = useLanguage();

  const rulesContent = {
    en: {
      title: 'Game Rules',
      rules: [
        'The game unfolds over five rounds: three are dedicated to revealing clues about the crime and the characters, while the remaining two involve voting to expose the secrets of players deemed suspicious.',
        'Each player will receive details about how they arrived at the crime scene and their connection to the victim. These two traits are public knowledge and should be openly shared with the group. In addition, each player holds a secret that must be kept hidden, as it could make them a prime suspect. If a player is selected by the majority during a revelation round, their secret will be exposed.',
        'Game Objective:',
        'All players, except for the murderer, aim to identify the true culprit. Meanwhile, the murderer’s objective is to deflect suspicion onto others in order to escape justice.',
        'The murderer is suffering from amnesia and doesn\'t remember committing the crime. No player\'s secret reveals whether they are the killer. As a result, everyone will be searching for guilt in others — because if you\'re ultimately identified as the murderer, you automatically lose the game.'
      ]
    },
    bg: {
      title: 'Правила на играта',
      rules: [
        'Играта се провежда в 5 рунда. Три от тях разкриват улики, свързани с престъплението и героите в играта, а останалите 2 се използват за разкриване на тайни на избрани подозрителни играчи, посредством гласуване.',
        'Всеки играч ще получи информация за това как се е озовал на местопрестъплението и от къде се познава с жертвата. Тези 2 негови характеристики са общоизвестни и той трябва да ги сподели с останалите. Всеки играч притежава и тайна, която не трябва да споделя с останалите, защото може да го превърне в основен заподозрян. Ако бъде избран с мнозинство по време на разкриващ рунд, играта ще разкрие тайната му вместо него.',
        'Цел на играта:',
        'Всички играчи освен убиеца имат за цел да разкрият извършителя, който пък от своя страна има за цел да прехвърли вината на друг, за да му се размине.',
        'Самият убиец "страда от амнезия" и не си спомня за извършеното (в тайната на нито един играч не пише дали той е убиецът). Това означава, че всеки участник ще търси вината у другите, защото бъде ли определен като финален избор за извършител, той автоматично губи играта.'
      ]
    }
  };

  const content = rulesContent[language as keyof typeof rulesContent];

  return (
    <div className="mystery-paper p-6 rounded-lg">
      <motion.div
        initial={{ opacity: 0, y: 10 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 0.5 }}
      >
        <h2 className="text-2xl font-display font-bold text-center mb-8">
          <span className="mr-2">📋</span>
          {content.title}
        </h2>
        
        <div className="space-y-6">
          {content.rules.map((rule, index) => (
            <motion.div
              key={index}
              initial={{ opacity: 0, x: -10 }}
              animate={{ opacity: 1, x: 0 }}
              transition={{ duration: 0.3, delay: index * 0.1 }}
              className={`${
                index === 2 ? 'font-semibold text-lg text-primary-700' : 'text-secondary-700'
              } leading-relaxed`}
            >
              {rule}
            </motion.div>
          ))}
        </div>
        
        <div className="mt-8 p-4 bg-primary-50 rounded-lg border-l-4 border-primary-500">
          <p className="text-primary-800 font-medium">
            {language === 'bg' 
              ? '💡 Съвет: Внимателно следвайте уликите и обсъждайте подозренията си с другите играчи!' 
              : '💡 Tip: Carefully follow the clues and discuss your suspicions with other players!'
            }
          </p>
        </div>
      </motion.div>
    </div>
  );
};

export default GameRulesScreen; 