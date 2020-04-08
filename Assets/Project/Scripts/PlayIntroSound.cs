using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayIntroSound : MonoBehaviour
{
    private AudioSource makeSound;
    public AudioClip IntroSound;
    public float PlayIntroTime;
    private float IntroPlaying;
    private bool BeginIntro = false;
    private bool PlayedIntro = false;

    public bool LoopSound;

    // Start is called before the first frame update
    void Awake()
    {
        PlayedIntro = false;
        BeginIntro = true;
        IntroPlaying = 0.0f;

        makeSound.loop = LoopSound;
    }

    // Update is called once per frame
    void Update()
    {
        if (BeginIntro && !PlayedIntro)
        {
            IntroPlaying += Time.deltaTime;
            if (IntroPlaying >= PlayIntroTime)
            {
                //Play IntroAudio
                makeSound.clip = IntroSound;
                makeSound.Play();
                PlayedIntro = true;
            }
        }
    }
}
