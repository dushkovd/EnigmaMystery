export interface Character {
  name: string;
  secret: string;
}

export interface Clue {
  id: string;
  text: string;
}

export interface Round {
  title: string;
  clues: Clue[];
}

export interface Game {
  id: string;
  title: string;
  subtitle: string;
  price: number;
  image: string;
  description: string;
  shortDescription: string;
  setting: string;
  crime: {
    victim: string;
    time: string;
    cause: string;
    discoveredBy: string;
  };
  characters: Character[];
  rounds: Round[];
  solution: {
    murderer: string;
    explanation: string;
  };
  difficulty: 'Easy' | 'Medium' | 'Hard';
  players: string;
  duration: string;
  featured?: boolean;
}

export const games: Game[] = [
  {
    id: 'death-at-rosewood',
    title: 'Death at the Rosewood Estate',
    subtitle: 'A 1920s Dinner Party Murder',
    price: 29.99,
    image: 'https://images.pexels.com/photos/1029599/pexels-photo-1029599.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    description: 'Immerse yourself in the glamorous 1920s as you attend a lavish dinner party at the Rosewood Estate. When the wealthy host is found dead, it\'s up to you and your fellow guests to solve the mystery before the killer strikes again.',
    shortDescription: 'A glamorous 1920s dinner party turns deadly when the wealthy host is found poisoned.',
    setting: 'A lavish 1920s dinner party at the Rosewood Estate, hosted by the wealthy yet secretive Harold Langston. The occasion? A charity fundraiser… or so it seemed.',
    crime: {
      victim: 'Harold Langston',
      time: 'Shortly after dinner, around 9:45 PM',
      cause: 'Poison in his glass of brandy',
      discoveredBy: 'The butler, James, while delivering cigars'
    },
    characters: [
      {
        name: 'Evelyn Langston',
        secret: 'Was about to be cut out of the will.'
      },
      {
        name: 'Dr. Lionel Graves',
        secret: 'Prescribed Harold sedatives that could mask poisoning symptoms.'
      },
      {
        name: 'Catherine Blake',
        secret: 'Forged Harold\'s signature on several documents, including a check.'
      },
      {
        name: 'Lord Reginald Ashcroft',
        secret: 'Owed Harold a massive gambling debt.'
      },
      {
        name: 'Beatrice Langston',
        secret: 'Knew Harold planned to marry again and write her out of the will.'
      },
      {
        name: 'Marcus Reed',
        secret: 'Had a romantic affair with Evelyn.'
      },
      {
        name: 'James the Butler',
        secret: 'Overheard blackmail material and has been eavesdropping for weeks.'
      },
      {
        name: 'Anna the Maid',
        secret: 'Saw someone sneaking into the study the night before the murder.'
      }
    ],
    rounds: [
      {
        title: 'Initial Discovery',
        clues: [
          {
            id: 'clue1',
            text: 'Smell of bitter almonds on his lips (suggests cyanide).'
          },
          {
            id: 'clue2',
            text: 'Harold drank alone in the study before joining the party.'
          },
          {
            id: 'clue3',
            text: 'Only a few guests knew Harold drank brandy, not wine.'
          }
        ]
      },
      {
        title: 'Interrogations Begin',
        clues: [
          {
            id: 'clue4',
            text: 'Crumpled note in the study trash bin – "If you don\'t confess, I will."'
          },
          {
            id: 'clue5',
            text: 'Maid Anna saw Evelyn sneaking into the study around 8 PM.'
          },
          {
            id: 'clue6',
            text: 'Empty cyanide vial found in Dr. Graves\' bag (he claims it\'s for medical use).'
          }
        ]
      },
      {
        title: 'The Web Untangles',
        clues: [
          {
            id: 'clue7',
            text: 'Forged Will found in Catherine\'s drawer, dated last week.'
          },
          {
            id: 'clue8',
            text: 'Love letters between Marcus and Evelyn.'
          },
          {
            id: 'clue9',
            text: 'Financial ledger showing Reginald owed over £100,000, and Harold planned to expose him.'
          }
        ]
      }
    ],
    solution: {
      murderer: 'Evelyn Langston',
      explanation: 'She discovered Harold planned to divorce her and cut her from the will. She slipped cyanide into his brandy before dinner, knowing his habits. She planted misleading clues to frame Dr. Graves and Catherine.'
    },
    difficulty: 'Medium',
    players: '6-8 players',
    duration: '2-3 hours',
    featured: true
  },
  {
    id: 'betrayal-at-blackrock',
    title: 'Betrayal at Blackrock Manor',
    subtitle: 'A Victorian Tale of Deception',
    price: 34.99,
    image: 'https://images.pexels.com/photos/6447217/pexels-photo-6447217.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    description: 'Step into the mysterious world of Victorian England at the grand Blackrock Manor. When the patriarch is found dead in the library, suspicion falls on everyone from the distant relatives to the loyal staff. Can you unravel the web of lies before the killer escapes?',
    shortDescription: 'A Victorian family gathering at Blackrock Manor turns deadly when the patriarch is murdered.',
    setting: 'The grand halls of Blackrock Manor, an isolated Victorian estate shrouded in fog. The Blackrock family has gathered to celebrate the 70th birthday of Lord Edmund Blackrock, a notorious businessman with many enemies.',
    crime: {
      victim: 'Lord Edmund Blackrock',
      time: 'During the midnight toast',
      cause: 'Stabbed with an antique letter opener',
      discoveredBy: 'His granddaughter, Eleanor'
    },
    characters: [
      {
        name: 'Lady Victoria Blackrock',
        secret: 'Has been slowly poisoning Edmund for months to inherit early.'
      },
      {
        name: 'Jonathan Blackrock',
        secret: 'Recently discovered he was adopted and has no claim to the family fortune.'
      },
      {
        name: 'Eleanor Blackrock',
        secret: 'In severe debt from gambling and needs her inheritance immediately.'
      },
      {
        name: 'Mr. Harrison',
        secret: 'The butler who has been blackmailed by Edmund for years.'
      },
      {
        name: 'Dr. Montgomery',
        secret: 'Helped Edmund fake medical records for insurance fraud.'
      },
      {
        name: 'Miss Winters',
        secret: 'Edmund\'s secretary who discovered embezzlement in the family business.'
      },
      {
        name: 'Inspector Collins',
        secret: 'Has been paid to overlook Edmund\'s illegal business dealings for years.'
      }
    ],
    rounds: [
      {
        title: 'The Grim Discovery',
        clues: [
          {
            id: 'clue1',
            text: 'The letter opener belongs to Lady Victoria\'s collection.'
          },
          {
            id: 'clue2',
            text: 'Lord Edmund changed his will earlier that day.'
          },
          {
            id: 'clue3',
            text: 'A secret passage connects the library to the east wing.'
          }
        ]
      },
      {
        title: 'Family Secrets',
        clues: [
          {
            id: 'clue4',
            text: 'Jonathan found adoption papers in Edmund\'s safe.'
          },
          {
            id: 'clue5',
            text: 'Eleanor has pawn tickets for family heirlooms in her purse.'
          },
          {
            id: 'clue6',
            text: 'Lady Victoria has a book on untraceable poisons in her chamber.'
          }
        ]
      },
      {
        title: 'The Final Pieces',
        clues: [
          {
            id: 'clue7',
            text: 'Miss Winters has evidence of the Blackrock company\'s financial fraud.'
          },
          {
            id: 'clue8',
            text: 'A bloodied glove found in the garden matches Inspector Collins\' size.'
          },
          {
            id: 'clue9',
            text: 'Mr. Harrison was seen entering the passage minutes before the murder.'
          }
        ]
      }
    ],
    solution: {
      murderer: 'Mr. Harrison',
      explanation: 'After years of blackmail and humiliation, Mr. Harrison finally snapped when Lord Edmund threatened to reveal his past crimes. He used the secret passage to enter the library undetected, took Lady Victoria\'s letter opener, and stabbed Edmund during a moment when the lights were dimmed for the toast.'
    },
    difficulty: 'Hard',
    players: '7-10 players',
    duration: '3-4 hours'
  },
  {
    id: 'murder-on-the-orient-starlight',
    title: 'Murder on the Orient Starlight',
    subtitle: 'A Luxury Train Journey Gone Wrong',
    price: 24.99,
    image: 'https://images.pexels.com/photos/2537460/pexels-photo-2537460.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    description: 'All aboard the Orient Starlight, the most luxurious train journey across Europe! When a mysterious passenger is found dead in their compartment as the train passes through the Alps, everyone becomes a suspect. Can you solve the case before the train reaches its final destination?',
    shortDescription: 'A mysterious passenger is found dead on the luxurious Orient Starlight train crossing Europe.',
    setting: 'The elegant Orient Starlight train, crossing the snowy Alps in the winter of 1935. The train is filled with an eclectic mix of wealthy travelers, diplomats, and mysterious strangers.',
    crime: {
      victim: 'Professor Lawrence Harrington',
      time: 'Between 1 and 3 AM',
      cause: 'Strangled with a silk scarf',
      discoveredBy: 'The conductor, Marcel'
    },
    characters: [
      {
        name: 'Countess Sophia Romanov',
        secret: 'Not actually a countess, but a con artist with multiple identities.'
      },
      {
        name: 'Colonel James Winters',
        secret: 'Carrying secret military documents the Professor was trying to steal.'
      },
      {
        name: 'Madame Dubois',
        secret: 'Her jewelry business is a front for smuggling operations.'
      },
      {
        name: 'Dr. William Carter',
        secret: 'Was treating the Professor for a terminal illness no one knew about.'
      },
      {
        name: 'Miss Amelia Parker',
        secret: 'Professor Harrington\'s former student who he plagiarized and ruined academically.'
      },
      {
        name: 'Mr. Takahashi',
        secret: 'A diplomat who was being blackmailed by the Professor.'
      },
      {
        name: 'Marcel the Conductor',
        secret: 'Has a criminal past and recognized the Professor from a previous heist.'
      }
    ],
    rounds: [
      {
        title: 'The Initial Investigation',
        clues: [
          {
            id: 'clue1',
            text: 'The Professor\'s compartment was locked from the inside.'
          },
          {
            id: 'clue2',
            text: 'A broken watch found on the floor, stopped at 1:47 AM.'
          },
          {
            id: 'clue3',
            text: 'Sleeping medication in the Professor\'s glass of water.'
          }
        ]
      },
      {
        title: 'Passenger Interrogations',
        clues: [
          {
            id: 'clue4',
            text: 'Miss Parker was seen arguing with the Professor in the dining car.'
          },
          {
            id: 'clue5',
            text: 'The silk scarf matches one from Madame Dubois\' collection.'
          },
          {
            id: 'clue6',
            text: 'Colonel Winters\' compartment had been searched.'
          }
        ]
      },
      {
        title: 'Hidden Connections',
        clues: [
          {
            id: 'clue7',
            text: 'A photograph showing the Countess and Professor at a casino years ago.'
          },
          {
            id: 'clue8',
            text: 'Secret compartment in the Professor\'s luggage containing multiple passports.'
          },
          {
            id: 'clue9',
            text: 'Telegram warning the Professor: "They know who you are. Get off at Zurich."'
          }
        ]
      }
    ],
    solution: {
      murderer: 'Countess Sophia Romanov',
      explanation: 'The "Countess" and the Professor were former partners in crime. When she discovered he was planning to expose her current con to save himself from other enemies, she drugged his water, waited until he fell asleep, and strangled him with her scarf. She then locked the door from inside and escaped through the connecting door to the adjacent empty compartment she had secretly booked.'
    },
    difficulty: 'Easy',
    players: '5-7 players',
    duration: '2 hours'
  }
];

export const getGameById = (id: string): Game | undefined => {
  return games.find(game => game.id === id);
};