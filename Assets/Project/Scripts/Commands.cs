using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class Commands : MonoBehaviour
{
    // Image overlay for fade
    public RawImage fadeImage;
    // Rate at which things fade 
    public float timeToFade = 2.0f;

    /// <summary>
    /// Fade in or out  - 1 represents fade in, 0 represents fade out
    /// just a bit easier to understand than using a hoolean
    /// In reference to image, so fade out ends with the image invisable
    /// </summary>
    public enum FadeDirection
    {
        In, //Alpha = 1
        Out // Alpha = 0
    }

    /// <summary>
    /// Fades in or out before loading the next scene
    /// </summary>
    /// <param name="fadeDirection">a fadedirection object that says in or out</param>
    /// <param name="nextScene">string scene name to load</param>
    /// <returns></returns>
    public IEnumerator LoadSceneWithFade(FadeDirection fadeDirection, string nextScene)
    {
        Debug.Log("yield start");
        yield return Fade(fadeDirection);
        Debug.Log("yield complete");
        SceneManager.LoadScene(nextScene);
    }

    // Heavily based on: https://gamedevelopertips.com/unity-how-fade-between-scenes/
    private IEnumerator Fade(FadeDirection fadeDirection)
    {
        float alpha = (fadeDirection == FadeDirection.Out) ? 1 : 0;
        float alphaFinal = (fadeDirection == FadeDirection.Out) ? 0 : 1;
        if (fadeDirection == FadeDirection.Out)
        {
            while (alpha >= alphaFinal)
            {
                SetColorImage(ref alpha, fadeDirection);
                yield return null;
            }
            fadeImage.enabled = false;
        }
        else
        {
            fadeImage.enabled = true;
            while (alpha <= alphaFinal)
            {
                SetColorImage(ref alpha, fadeDirection);
                yield return null;
            }
        }
    }

    private void SetColorImage(ref float alpha, FadeDirection fadeDirection)
    {
        fadeImage.color = new Color(fadeImage.color.r, fadeImage.color.g, fadeImage.color.b, alpha);
        alpha += Time.deltaTime * (1.0f / timeToFade) * ((fadeDirection == FadeDirection.Out) ? -1 : 1);
    }


    
    public void StartSimulation()
    {
        Debug.Log("Start Simulation");
        StartCoroutine(LoadSceneWithFade(FadeDirection.In, "GameScene"));
    }

    public void MainMenu()
    {
        LoadSceneWithFade(FadeDirection.In, "Start");
    }

    public void QuitSimulation()
    {
        Application.Quit();
    }

    // Fades out when scene loads
    void OnEnable()
    {
        StartCoroutine(Fade(FadeDirection.Out));
    }
}
